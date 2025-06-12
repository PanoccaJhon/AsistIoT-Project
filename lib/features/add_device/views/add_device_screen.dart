import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/add_device_viewmodel.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  @override
  void initState() {
    super.initState();
    // Usamos addPostFrameCallback para asegurarnos que el ViewModel esté listo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddDeviceViewModel>(context, listen: false).startScan();
    });
  }

  @override
  void dispose() {
    // Detenemos el escaneo al salir de la pantalla para ahorrar batería
    Provider.of<AddDeviceViewModel>(context, listen: false).stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddDeviceViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Añadir Nuevo Dispositivo')),
        body: Consumer<AddDeviceViewModel>(
          builder: (context, viewModel, child) {
            // Si no hemos seleccionado un dispositivo, mostramos la lista de escaneo
            if (viewModel.selectedDevice == null) {
              return _buildScanningUI(context, viewModel);
            } else {
              // Si ya seleccionamos uno, mostramos el formulario de WiFi
              return _buildWifiFormUI(context, viewModel);
            }
          },
        ),
      ),
    );
  }

  Widget _buildScanningUI(BuildContext context, AddDeviceViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Buscando dispositivos cercanos...',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        viewModel.isScanning ? 
          const LinearProgressIndicator() 
        : 
          TextButton(
          onPressed: viewModel.startScan,
          child: const Text('Reiniciar Escaneo'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.scanResults.length,
            itemBuilder: (context, index) {
              final result = viewModel.scanResults[index];
              return ListTile(
                leading: const Icon(Icons.memory, size: 36),
                title: Text(result.device.platformName.isEmpty
                    ? '(Dispositivo sin nombre)'
                    : result.device.platformName),
                subtitle: Text(result.device.remoteId.toString()),
                onTap: () => viewModel.connectToDevice(result.device),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWifiFormUI(BuildContext context, AddDeviceViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conectado a: ${viewModel.selectedDevice!.platformName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Introduce las credenciales de tu red Wi-Fi para configurar el dispositivo.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: viewModel.ssidController,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Red Wi-Fi (SSID)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: viewModel.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña del Wi-Fi',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          if (viewModel.isConnecting)
            const Center(child: CircularProgressIndicator())
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final success = await viewModel.sendWifiCredentials();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success
                            ? '¡Credenciales enviadas! El dispositivo se reiniciará.'
                            : 'Error al enviar credenciales.'),
                      ),
                    );
                    if (success) Navigator.of(context).pop();
                  }
                },
                child: const Text('Configurar y Conectar'),
              ),
            ),
        ],
      ),
    );
  }
}