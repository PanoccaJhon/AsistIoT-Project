import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AddDeviceViewModel extends ChangeNotifier {
  // --- UUIDs ---
  // Estos UUIDs deben coincidir EXACTAMENTE con los definidos en el código del ESP32
  final Guid _serviceUuid = Guid("4fafc201-1fb5-459e-8fcc-c5c9c331914b");
  final Guid _characteristicUuid = Guid("beb5483e-36e1-4688-b7f5-ea07361b26a8");

  // --- Estado de la UI ---
  bool _isScanning = false;
  bool get isScanning => _isScanning;

  bool _isConnecting = false;
  bool get isConnecting => _isConnecting;

  List<ScanResult> _scanResults = [];
  List<ScanResult> get scanResults => _scanResults;
  
  BluetoothDevice? _selectedDevice;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  // --- Controladores para el formulario ---
  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void startScan() async{
    _isScanning = true;
    notifyListeners();
    // Limpiar resultados previos
    _scanResults.clear();
    // Empezar a escanear. Se puede filtrar por el Service UUID para encontrar solo nuestros dispositivos
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    await FlutterBluePlus.isScanning.firstWhere((isScanning) => !isScanning);
    // Escuchar los resultados
    FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      notifyListeners();
    });

    _isScanning = false;
    notifyListeners();
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    stopScan();
    _selectedDevice = device;
    _isConnecting = true;
    notifyListeners();
    
    try {
      await device.connect();
    } catch(e) {
      print("ERROR AL CONECTAR: $e");
      // Manejar error de conexión
    }
    _isConnecting = false;
    notifyListeners();
  }

  Future<bool> sendWifiCredentials() async {
    if (_selectedDevice == null) return false;

    _isConnecting = true;
    notifyListeners();

    try {
      // 1. Descubrir servicios
      List<BluetoothService> services = await _selectedDevice!.discoverServices();
      
      // 2. Encontrar nuestro servicio específico
      final targetService = services.firstWhere((s) => s.uuid == _serviceUuid);

      // 3. Encontrar nuestra característica específica
      final targetCharacteristic = targetService.characteristics.firstWhere((c) => c.uuid == _characteristicUuid);
      
      // 4. Formatear las credenciales en JSON
      final credentials = {
        "ssid": ssidController.text,
        "pass": passwordController.text
      };
      final jsonString = jsonEncode(credentials);
      final dataToSend = utf8.encode(jsonString); // Convertir a bytes

      // 5. Escribir los datos en la característica
      await targetCharacteristic.write(dataToSend);

      print("Credenciales enviadas exitosamente!");
      await _selectedDevice!.disconnect();
      _selectedDevice = null;
      _isConnecting = false;
      notifyListeners();
      return true;

    } catch (e) {
      print("ERROR AL ENVIAR CREDENCIALES: $e");
      _isConnecting = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}