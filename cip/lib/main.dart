import 'package:flutter/material.dart';
import 'screens/mapa_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/biomasa_screen.dart';
import 'screens/configuracion_screen.dart';

// La aplicación Flutter debe ser envuelta con proveedores de estado (Provider, Riverpod, etc.)
// para manejar la Configuración, Parcelas, y Snapshots. 
// Aquí usamos un StatefulWidget para simular el Provider de Zona/Estado.

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Inicialización de Isar (DB)
  // final isar = await Isar.open([ParcelaSchema, SnapshotSchema, ConfiguracionSchema]); 
  runApp(const PastoControlApp());
}

class PastoControlApp extends StatefulWidget {
  const PastoControlApp({super.key});

  @override
  State<PastoControlApp> createState() => _PastoControlAppState();
}

class _PastoControlAppState extends State<PastoControlApp> {
  // Simulación de estado global:
  String _currentZone = 'Tambokarka';
  int _currentIndex = 0; // Índice de la navegación inferior

  final List<String> _zones = ['Tambokarka', 'Chalhuani'];
  
  // Definición de las pantallas, que dependen de la zona actual
  List<Widget> _getScreens() {
    return [
      DashboardScreen(zona: _currentZone),
      MapaScreen(zona: _currentZone),
      BiomasaScreen(zona: _currentZone),
      ConfiguracionScreen(zona: _currentZone),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  void _onZoneChanged(String? newZone) {
    if (newZone != null && _zones.contains(newZone)) {
      setState(() {
        _currentZone = newZone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // En una aplicación Flutter real, aquí se usaría MultiProvider
    return MaterialApp(
      title: 'PastoControl',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Si se usa una fuente personalizada
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _getScreens()[_currentIndex],
        
        // Cabecera con Selector de Zona
        appBar: AppBar(
          title: const Text('PastoControl', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: false,
          actions: [
            DropdownButton<String>(
              value: _currentZone,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: Colors.indigo,
              underline: Container(), // Eliminar la línea de underline
              items: _zones.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: _onZoneChanged,
            ),
          ],
        ),
        
        // Navegación Inferior (BottomNavigationBar)
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Biomasa'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
          ],
        ),
      ),
    );
  }
}