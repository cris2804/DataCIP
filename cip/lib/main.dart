import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/parcela_state_service.dart';
import 'screens/dashboard_screen.dart';
import 'screens/mapa_screen.dart';
import 'screens/biomasa_screen.dart';
import 'screens/configuracion_screen.dart';

void main() {
  runApp(const PastoControlApp());
}

class PastoControlApp extends StatelessWidget {
  const PastoControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNavState()), // AppNavState primero
        ChangeNotifierProvider(
          create: (context) => ParcelaStateService()
            ..loadDataForZone(context.read<AppNavState>().currentZone), // Carga datos iniciales
        ),
      ],
      child: MaterialApp(
        title: 'PastoControl',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const MainScaffold(),
      ),
    );
  }
}

// Provider para manejar el estado de la navegación (zona y tab actual)
class AppNavState extends ChangeNotifier {
  String _currentZone = 'Tambokarka';
  int _currentIndex = 0;
  final List<String> zones = ['Tambokarka', 'Challhuani'];

  String get currentZone => _currentZone;
  int get currentIndex => _currentIndex;

  void onTabTapped(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void onZoneChanged(BuildContext context, String? newZone) {
    if (newZone != null && zones.contains(newZone)) {
      _currentZone = newZone;
      // Recarga los datos de la parcela para la nueva zona
      context.read<ParcelaStateService>().loadDataForZone(newZone);
      notifyListeners();
    }
  }
}

// Widget que construye la UI principal (AppBar, Body, BottomNav)
class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final appNav = Provider.of<AppNavState>(context);

    final List<Widget> screens = [
      DashboardScreen(zona: appNav.currentZone),
      MapaScreen(zona: appNav.currentZone),
      BiomasaScreen(zona: appNav.currentZone),
      ConfiguracionScreen(zona: appNav.currentZone),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('PastoControl', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: false,
        actions: [
          DropdownButton<String>(
            value: appNav.currentZone,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.indigo,
            underline: Container(),
            items: appNav.zones.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (zone) => appNav.onZoneChanged(context, zone),
          ),
        ],
      ),
      body: screens[appNav.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appNav.currentIndex,
        onTap: (index) => appNav.onTabTapped(index),
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
    );
  }
}
