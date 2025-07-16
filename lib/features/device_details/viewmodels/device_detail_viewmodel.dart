import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../data/models/light_device.dart'; // Asegúrate de que la ruta sea correcta
import '../../../core/services/iot_repository.dart';

class DeviceDetailViewModel extends ChangeNotifier {
  final String deviceId;
  final IotRepository _repository;

  LightDevice? _device;
  LightDevice? get device => _device;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DeviceDetailViewModel({
    required this.deviceId,
    required IotRepository repository,
  }) : _repository = repository {
    // Al crear el ViewModel, inmediatamente busca los detalles del dispositivo.
    _fetchDeviceDetails();
  }

  /// Obtiene el estado más reciente del dispositivo desde el repositorio.
  Future<void> _fetchDeviceDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final deviceData = await _repository.getDeviceState(deviceId);
      _device = LightDevice.fromJson(deviceId, deviceId, deviceData); // Asumiendo name = id
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
  Future<void> toggleLight(bool isOn) async {
    if (_device == null) return;

    final originalState = _device!;
    // Actualización optimista: Cambia el estado en la UI inmediatamente.
    _device = _device!.copyWith(isOn: isOn);
    notifyListeners();

    try {
      final command = {'estado_luces': {'luz1': isOn ? 'ON' : 'OFF'}};
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
      final command = {'config': {'modo_auto': isAuto}};
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
}