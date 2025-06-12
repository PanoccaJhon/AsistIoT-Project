import 'package:asistiot_project/features/add_device/views/add_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../models/light_device.dart';
import '../../device_details/views/device_detail_screen.dart';

// V: Widget que muestra la UI. No contiene lógica de estado.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Se conecta al ViewModel usando Provider.
    // context.watch hace que este widget se reconstruya cuando notifyListeners() es llamado.
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Hogar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegamos a la pantalla de detalles, pasando el ID del dispositivo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDeviceScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildBody(context, viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar la captura de voz con un paquete como speech_to_text
          // y luego llamar al viewmodel.
          // Por ejemplo:
          // final speechResult = await startListening();
          // viewModel.processVoiceCommand(speechResult);
          
          // Simulación para prueba:
          viewModel.processVoiceCommand("encender luz del dormitorio");
        },
        tooltip: 'Control por Voz',
        child: const Icon(Icons.mic),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (viewModel.devices.isEmpty) {
      return const Center(child: Text('No hay dispositivos. Añade uno.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: viewModel.devices.length,
      itemBuilder: (context, index) {
        final device = viewModel.devices[index];
        return _DeviceCard(device: device);
      },
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({required this.device});

  final LightDevice device;

  @override
  Widget build(BuildContext context) {
    // Usamos context.read dentro de callbacks para llamar a funciones del ViewModel
    // sin causar que este widget se reconstruya innecesariamente.
    final viewModel = context.read<HomeViewModel>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          // Navegamos a la pantalla de detalles, pasando el ID del dispositivo
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceDetailScreen(deviceId: device.id),
            ),
          );
        },
        leading: Icon(
          Icons.lightbulb_outline,
          color: device.isOn ? Colors.amber.shade700 : Colors.grey.shade600,
          size: 40,
        ),
        title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          'Modo automático: ${device.isAutoMode ? "Activado" : "Desactivado"}\nNivel de luz: ${device.lightLevel ?? "N/A"} lux',
        ),
        trailing: Switch.adaptive(
          value: device.isOn,
          onChanged: (newValue) {
            // Llama a la acción en el ViewModel
            viewModel.toggleLight(device.id);
          },
        ),
      ),
    );
  }
}