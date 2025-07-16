import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../core/services/iot_repository.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/models/light_device.dart';

class HomeViewModel extends ChangeNotifier {
  final IotRepository _repository;
  final AuthService _authService;

  HomeViewModel({
    required IotRepository repository,
    required AuthService authService,
  })  : _repository = repository,
        _authService = authService;

  // --- ESTADO ---
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<LightDevice> _devices = [];
  List<LightDevice> get devices => List.unmodifiable(_devices);

  String? _userDisplayName;
  String? get userDisplayName => _userDisplayName;

  // AÑADIDO: Estado para el email del usuario
  String? _userEmail;
  String? get userEmail => _userEmail;
  // ------------------------------------------

  // --- LÓGICA / ACCIONES ---

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      _loadCurrentUser(),
      _fetchDevices(),
    ]);
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.wait([
      _loadCurrentUser(),
      _fetchDevices(),
    ]);
    notifyListeners();
  }
  
  // MODIFICADO: Ahora también obtiene y guarda el email.
  Future<void> _loadCurrentUser() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();

      // Buscar el nombre para mostrar
      final nameAttribute = attributes.firstWhere(
        (element) => element.userAttributeKey == AuthUserAttributeKey.name,
        orElse: () => attributes.firstWhere(
          (element) => element.userAttributeKey == AuthUserAttributeKey.email,
        ),
      );

      final emailAttribute = attributes.firstWhere(
        (element) => element.userAttributeKey == AuthUserAttributeKey.email,
        orElse: () => throw Exception('Email no disponible'),
      );

      _userDisplayName = nameAttribute.value;
      _userEmail = emailAttribute.value;

      // AÑADIDO: Buscar el email y guardarlo en su propia variable.
      try {
        final emailAttribute = attributes.firstWhere(
          (element) => element.userAttributeKey == AuthUserAttributeKey.email,
        );
        _userEmail = emailAttribute.value;
      } catch (e) {
        _userEmail = 'Email no disponible';
      }

    } on Exception catch (e) {
      print("Error cargando atributos del usuario: $e");
      _userDisplayName = "Usuario";
      _userEmail = ""; // Valores por defecto en caso de error
    }
  }

  Future<void> _fetchDevices() async {
    try {
      _devices = await _repository.getDevices();
    } catch(e) {
      print("Error obteniendo dispositivos: $e");
      _devices = [];
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> toggleLight(String deviceId) async {
    final deviceIndex = _devices.indexWhere((d) => d.id == deviceId);
    if (deviceIndex == -1) return;

    final device = _devices[deviceIndex];
    final newStatus = !device.isOn;
    
    final originalDevices = List<LightDevice>.from(_devices);

    _devices[deviceIndex] = device.copyWith(isOn: newStatus);
    notifyListeners();

    try {
      final command = {'estado_luces': {'luz1': newStatus ? 'ON' : 'OFF'}};
      await _repository.sendCommand(deviceId, jsonEncode(command));
    } catch (e) {
      _devices = originalDevices;
      print("Error al enviar comando, revirtiendo estado: $e");
      notifyListeners();
    }
  }

  Future<void> processVoiceCommand(String command) async {
    // Aquí podrías implementar lógica para procesar comandos de voz
    // Por ejemplo, encender/apagar luces, cambiar modos, etc.
    // Este es un ejemplo simple que solo imprime el comando.
    print("Comando de voz recibido: $command");
    
    // Podrías llamar a toggleLight o cualquier otra acción según el comando.
  }
}