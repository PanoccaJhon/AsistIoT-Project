import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/iot_repository.dart';
import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/home/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

//...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Proveemos el repositorio y luego el ViewModel que depende de él.
    return MultiProvider(
      providers: [
        // Proveemos una instancia del repositorio para que toda la app pueda acceder a ella.
        Provider<IotRepository>(create: (_) => MockIotRepository()),
        // El ViewModel del Home usa el repositorio provisto arriba.
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(
            repository: context.read<IotRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
       title: 'IoT Home Control',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}