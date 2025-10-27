import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/parcela.dart'; // <--- ESTA LÍNEA ES CLAVE

// Asumimos un provider para gestionar el estado de Parcela/Zona
// import '../providers/pasto_control_provider.dart'; 
// import 'package:flutter_map/flutter_map.dart'; // Requerido para el mapa

class MapaScreen extends StatelessWidget {
  final String zona;

  const MapaScreen({super.key, required this.zona});

  // Método simulado para mostrar el modal de edición
  void _showEditModal(BuildContext context, Parcela parcela) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditParcelModal(parcela: parcela)));
    // Implementación del modal de edición de estado de la Parcela...
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PastoControlProvider>(context);
    // final parcelas = provider.getParcelasPorZona(zona);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa y Edición ($zona)'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Lógica para exportar GeoJSON actualizado
            },
            tooltip: 'Exportar GeoJSON',
          ),
        ],
      ),
      body: Column(
        children: [
          // SIMULACIÓN DE MAPA (En Flutter real, iría aquí el widget de MapLibre GL)
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map, size: 80, color: Colors.indigo),
                    Text('Visualización del Mapa Offline de $zona'),
                    const Text('Áreas interactivas para edición (Simulación)'),
                  ],
                ),
              ),
            ),
          ),
          // Lista de Parcelas (similar a la simulación web para edición manual)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Lista de Parcelas (Tocar para editar estado):', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              // itemCount: parcelas.length,
              itemCount: 10, // Simulación
              itemBuilder: (context, index) {
                // final parcela = parcelas[index];
                final String estadoSimulado = index % 3 == 0 ? 'restaurado' : 'en_proceso';
                return ListTile(
                  title: Text('Parcela ${zona.substring(0, 3)}_${index + 1}'),
                  subtitle: Text('Estado: $estadoSimulado'),
                  trailing: Icon(Icons.edit, color: Colors.indigo),
                  onTap: () {
                    // _showEditModal(context, parcela); // Llamada al modal de edición
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
