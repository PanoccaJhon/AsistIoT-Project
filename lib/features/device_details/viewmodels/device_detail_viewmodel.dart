import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../data/models/light_device.dart'; // Asegúrate de que la ruta sea correcta
import '../../../core/services/iot_repository.dart';
import '../../../core/services/voice_service.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceDetailViewModel extends ChangeNotifier {
  final String deviceId;
  final IotRepository _repository;

  final ModernVoiceService _voiceService;

  LightDevice? _device;
  LightDevice? get device => _device;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // --- NUEVAS VARIABLES PARA COMANDOS DE VOZ ---
  bool _isListening = false;
  bool get isListening => _isListening;

  String _voiceStatus = "Presiona para hablar";
  String get voiceStatus => _voiceStatus;

  bool _isVoiceServiceInitialized = false;


  DeviceDetailViewModel({
    required this.deviceId,
    required IotRepository repository,
  })  : _repository = repository,
  // Inicializa el servicio con los datos necesarios
        _voiceService = ModernVoiceService(
          projectId: 'asistiot-agent-a9mb', // Tu Project ID de Google Cloud
          credentialsPath: 'assets/dialogflow_credentials.json',
        ) {
    _fetchDeviceDetails();
  }

  /// Obtiene el estado más reciente del dispositivo desde el repositorio.
  Future<void> _fetchDeviceDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final device = await _repository.getDeviceById(deviceId);
      final state = await _repository.getDeviceState(deviceId);
      // Actualiza el dispositivo con los datos obtenidos
      _device = device.copyWith(
        online: state['online'] ?? false,
        lastSeenTimestamp: state['last_updated'] as int? ?? 0,
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cargar los datos del dispositivo: $e';
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Permite refrescar los datos desde la UI (ej. con un pull-to-refresh).
  Future<void> refresh() async {
    await _fetchDeviceDetails();
  }

  /// Envía el comando para encender/apagar una luz.
  Future<void> toggleLight(bool isOn, int luzIndex) async {
    if (_device == null) return;

    final originalState = _device!;
    // Actualización optimista: Cambia el estado en la UI inmediatamente.
    if (luzIndex == 1) {
      _device = _device!.copyWith(luz1: isOn);
    } else if (luzIndex == 2) {
      _device = _device!.copyWith(luz2: isOn);
    }
    notifyListeners();

    try {
      final command = {
        'luz1': _device!.luz1 ? 'ON' : 'OFF',
        'luz2': _device!.luz2 ? 'ON' : 'OFF',
      };
      await _repository.sendCommand(deviceId, jsonEncode(command));
    } catch (e) {
      // Si falla, revierte al estado original y muestra el error.
      _device = originalState;
      _errorMessage = 'Fallo al enviar comando de luz.';
      print('Error en toggleLight: $e');
      notifyListeners();
    }
  }

  /// Envía el comando para activar/desactivar el modo automático.
  Future<void> toggleAutoMode(bool isAuto) async {
    if (_device == null) return;

    final originalState = _device!;
    // Actualización optimista
    _device = _device!.copyWith(isAutoMode: isAuto);
    notifyListeners();

    try {
      final command = {'modo_auto': isAuto};
      await _repository.sendCommand(deviceId, jsonEncode(command));
    } catch (e) {
      // Reversión en caso de error
      _device = originalState;
      _errorMessage = 'Fallo al cambiar modo automático.';
      print('Error en toggleAutoMode: $e');
      notifyListeners();
    }
  }

  /// Llama al repositorio para desvincular el dispositivo.
  Future<bool> unlinkDevice() async {
    _isLoading = true;
    notifyListeners();
    try {
      // Esta función debe existir en tu repositorio y llamar a una Lambda DELETE.
      await _repository.unlinkDevice(deviceId);
      return true;
    } catch (e) {
      print('Error al desvincular: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

Future<bool> _requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    return status.isGranted;
  }
  Future<void> handleVoiceCommand() async {
    // Si ya está escuchando, el botón actúa como "detener".
    if (_isListening) {
      await _voiceService.stopListening();
      _isListening = false;
      _voiceStatus = "Cancelado. Presiona para hablar.";
      notifyListeners();
      return;
    }

    // 1. Inicializa el servicio la primera vez que se usa.
    if (!_isVoiceServiceInitialized) {
      _voiceStatus = "Inicializando...";
      notifyListeners();
      _isVoiceServiceInitialized = await _voiceService.initialize();
      if (!_isVoiceServiceInitialized) {
        _voiceStatus = "Error al iniciar el servicio de voz.";
        notifyListeners();
        return;
      }
    }

    // 2. Pide permisos de micrófono.
    final hasPermission = await _requestMicrophonePermission();
    if (!hasPermission) {
      _voiceStatus = "Permiso de micrófono denegado.";
      notifyListeners();
      return;
    }

    _isListening = true;
    _voiceStatus = "Escuchando...";
    notifyListeners();

    try {
      // 3. Llama al método principal del servicio.
      // Le pasamos un callback para actualizar la UI con el texto en tiempo real.
      final dialogflowResult = await _voiceService.listenAndDetectIntent(
        sessionId: deviceId,
        onSpeechResult: (text) {
          // Actualiza el estado para mostrar el texto reconocido en vivo.
          _voiceStatus = "Entendido: '$text'";
          notifyListeners();
        },
      );

      // 4. Una vez que se obtiene el resultado final de Dialogflow, se procesa.
      _isListening = false; // La escucha ha terminado.
      if (dialogflowResult != null) {
        _voiceStatus = "Procesando comando...";
        notifyListeners();
        _processDialogflowResult(dialogflowResult);
      } else {
        _voiceStatus = "No se detectó un comando. Intenta de nuevo.";
      }
    } catch (e) {
      _isListening = false;
      _voiceStatus = "Ocurrió un error. Intenta de nuevo.";
      print("Error en handleVoiceCommand: $e");
    }

    notifyListeners();
  }

  /// Procesa la respuesta de Dialogflow (este método no necesita grandes cambios).
  void _processDialogflowResult(Map<String, dynamic> queryResult) {
    final intent = queryResult['intent']?['displayName'];
    final parameters = queryResult['parameters'];

    if (intent == 'ControlDispositivo' && parameters != null) {
      bool commandRecognized = false;
      // ... (La lógica para procesar los parámetros y llamar a toggleLight, etc., es la misma que ya tenías)
      // Ejemplo:
      if (parameters.containsKey('accion') && parameters.containsKey('dispositivo')) {
        String accion = parameters['accion'];
        String dispositivo = parameters['dispositivo'];
        bool turnOn = (accion == 'enciende' || accion == 'prende');

        if (dispositivo == 'luz_1') {
          toggleLight(turnOn, 1);
          commandRecognized = true;
        } else if (dispositivo == 'luz_2') {
          toggleLight(turnOn, 2);
          commandRecognized = true;
        }
      }
      _voiceStatus = commandRecognized ? "Comando ejecutado" : "No entendí el dispositivo";
    } else {
      _voiceStatus = "El comando no es válido para este dispositivo.";
    }
  }

  @override
  void dispose() {
    _voiceService.stopListening();
    super.dispose();
  }


}
