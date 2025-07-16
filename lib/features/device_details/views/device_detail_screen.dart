import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/iot_repository.dart'; // Necesario para la inyección
import '../viewmodels/device_detail_viewmodel.dart';
// Asumiendo que tienes una pantalla de historial
// import 'history_screen.dart'; 

class DeviceDetailScreen extends StatelessWidget {
  final String deviceId;

  const DeviceDetailScreen({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeviceDetailViewModel(
        deviceId: deviceId,
        repository: Provider.of<IotRepository>(context, listen: false),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<DeviceDetailViewModel>(
            builder: (context, viewModel, child) {
              return Text(viewModel.device?.name ?? 'Cargando...');
            },
          ),
        ),
        body: Consumer<DeviceDetailViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (viewModel.device == null) {
              return const Center(child: Text('Dispositivo no encontrado.'));
            }

            final device = viewModel.device!;
            // Lógica para determinar si el dispositivo está conectado
            final isConnected = device.online; // Usamos el dato del shadow
            final lastSeen = device.lastSeenTimestamp != 0
                ? DateTime.fromMillisecondsSinceEpoch(device.lastSeenTimestamp)
                : null;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // --- INICIO DE NUEVOS WIDGETS ---

                  // Tarjeta de estado de conexión
                  Card(
                    child: ListTile(
                      leading: Icon(
                        isConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                        color: isConnected ? Colors.green : Colors.red,
                        size: 40,
                      ),
                      title: const Text('Estado de Conexión'),
                      subtitle: Text(
                        isConnected
                            ? 'Conectado'
                            : (lastSeen != null ? 'Última vez online: ${lastSeen.toLocal()}' : 'Desconocido'),
                      ),
                    ),
                  ),

                  // --- FIN DE WIDGETS DE CONTROL EXISTENTES ---
                  
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.lightbulb,
                        size: 40,
                        color: device.isOn ? Colors.amber : Colors.grey,
                      ),
                      title: const Text('Luz Principal'),
                      trailing: Switch.adaptive(
                        value: device.isOn,
                        onChanged: (value) {
                           viewModel.toggleLight(value);
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: SwitchListTile.adaptive(
                      title: const Text('Modo Automático'),
                      subtitle: const Text('Encendido por movimiento y poca luz'),
                      value: device.isAutoMode,
                      onChanged: (value) {
                        viewModel.toggleAutoMode(value);
                      },
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Datos de Sensores', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),
                          Text('Detección de Movimiento: ${device.motionDetected == true ? "Sí" : "No"}'),
                          const SizedBox(height: 8),
                          Text('Nivel de Iluminación: ${device.lightLevel} lux'),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24), // Espaciador

                  // --- INICIO DE NUEVOS BOTONES DE ACCIÓN ---

                  // Botón para ver historial
                  ElevatedButton.icon(
                    icon: const Icon(Icons.history_rounded),
                    label: const Text('Ver Historial de Movimientos'),
                    onPressed: () {
                      // Navegar a la pantalla de historial
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => HistoryScreen(deviceId: device.id),
                      // ));
                    },
                  ),

                  const SizedBox(height: 12),

                  // Botón para desvincular
                  ElevatedButton.icon(
                    icon: const Icon(Icons.link_off_rounded, color: Colors.white),
                    label: const Text('Desvincular Dispositivo', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                    ),
                    onPressed: () {
                      // Mostrar diálogo de confirmación antes de desvincular
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: const Text('¿Desvincular dispositivo?'),
                            content: const Text('Esta acción es permanente y eliminará el dispositivo de tu cuenta.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () => Navigator.of(dialogContext).pop(),
                              ),
                              TextButton(
                                child: const Text('Desvincular', style: TextStyle(color: Colors.red)),
                                onPressed: () async {
                                  // Llamar al método en el ViewModel
                                  final success = await viewModel.unlinkDevice();
                                  Navigator.of(dialogContext).pop(); // Cerrar diálogo
                                  if (success) {
                                    Navigator.of(context).pop(); // Volver a la lista
                                  } else {
                                    // Mostrar un snackbar de error si falla
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Error al desvincular el dispositivo.')),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}