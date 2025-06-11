import 'package:flutter/material.dart';
import '../../../core/services/iot_repository.dart';
import '../models/light_device.dart';

// VM: Contiene el estado y la lógica de la pantalla de inicio.
class HomeViewModel extends ChangeNotifier {
  final IotRepository _repository;

  HomeViewModel({required IotRepository repository}) : _repository = repository {
    // Carga los dispositivos cuando se crea el ViewModel
    fetchDevices();
  }

  // --- ESTADO ---
  // El estado que la vista observará. Es privado para que solo se modifique desde el ViewModel.

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<LightDevice> _devices = [];
  // Se expone una copia inmutable para que la vista no pueda modificarla directamente.
  List<LightDevice> get devices => List.unmodifiable(_devices);

  // --- LÓGICA / ACCIONES ---
  // Métodos que la vista puede llamar para ejecutar acciones.

  Future<void> fetchDevices() async {
    _isLoading = true;
    notifyListeners(); // Notifica a la UI que muestre un indicador de carga

    _devices = await _repository.getDevices();

    _isLoading = false;
    notifyListeners(); // Notifica a la UI que los datos están listos y oculte la carga
  }

  Future<void> toggleLight(String deviceId) async {
    final deviceIndex = _devices.indexWhere((d) => d.id == deviceId);
    if (deviceIndex == -1) return;

    final device = _devices[deviceIndex];
    final newStatus = !device.isOn;

    // Actualización optimista: Cambia el estado en la UI inmediatamente
    _devices[deviceIndex].isOn = newStatus;
    notifyListeners();

    try {
      // Llama al repositorio para actualizar el estado en el backend (AWS)
      await _repository.updateLightState(deviceId, newStatus);
    } catch (e) {
      // Si falla, revierte el cambio en la UI y muestra un error
      _devices[deviceIndex].isOn = !newStatus;
      notifyListeners();
      // Aquí mostrarías un SnackBar o diálogo de error.
    }
  }

  // Lógica de voz (a implementar)
  void processVoiceCommand(String command) {
    // 1. Analiza el comando (ej: "encender luz dormitorio")
    // 2. Identifica la acción ("encender") y el dispositivo ("dormitorio")
    // 3. Llama a la función correspondiente, ej: toggleLight('esp32-01')
    print("Comando de voz recibido: $command");
    // Esta es una implementación muy básica de ejemplo
    if (command.toLowerCase().contains('encender') && command.toLowerCase().contains('dormitorio')) {
      toggleLight('esp32-01');
    } else if (command.toLowerCase().contains('apagar') && command.toLowerCase().contains('dormitorio')) {
      final device = _devices.firstWhere((d) => d.id == 'esp32-01');
      if (device.isOn) { // Solo apaga si está encendida
        toggleLight('esp32-01');
      }
    }
  }
}