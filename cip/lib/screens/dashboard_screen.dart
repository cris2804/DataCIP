import 'package:flutter/material.dart';
import 'package:cip/services/biomasa_service.dart';
import 'package:cip/models/biomasa_dataset.dart';
// import 'package:provider/provider.dart';
// import 'package:fl_chart/fl_chart.dart'; // Para gráficos

class DashboardScreen extends StatelessWidget {
  final String zona;
  
  const DashboardScreen({super.key, required this.zona});

  // Datos por defecto en caso de no cargar el JSON
  final double pctDisponible = 30.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Indicadores ($zona)'),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<BiomasaDataset>(
        future: BiomasaService.loadDataset(),
        builder: (context, snapshot) {
          final contentPadding = const EdgeInsets.all(16.0);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          LugarBiomasa? lugarData;
          if (snapshot.hasData) {
            final byLugar = snapshot.data!.asByLugar();
            final zl = zona.toLowerCase();
            final key = (zl.contains('chalhuani') || zl.contains('challhuani')) ? 'challhuani' : 'tambokarka';
            lugarData = byLugar[key] ?? byLugar['tambokarka'];
          }
          return SingleChildScrollView(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // --- 1. Diseño tipo mockup: tarjeta superior con imagen de vicuña y fila de 3 cuadros coloreados ---
            // Tarjeta superior: Vicuñas alimentadas por año + imagen
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                height: 120,
                child: Row(
                  children: [
                    // Texto y valor
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('vicuñas alimentadas por año', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Builder(
                            builder: (_) {
                              if (lugarData == null) {
                                return const Text('-', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo));
                              }
                              final alimentadas = ((lugarData.biomasaDisponible * 0.3) / (lugarData.idmsKgMsDia * 365)).round();
                              return Text('$alimentadas', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo));
                            },
                          ),
                          if (lugarData != null)
                            Text('Vicuñas actuales: ${lugarData.cantidadVicunas}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Imagen de la vicuña (Network con fallback a icono)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/3/33/Vicugna_vicugna_-Peru-8.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 64),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Fila de 3 cuadros coloreados (verde, amarillo, rojo)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.terrain, color: Colors.white, size: 36),
                          const SizedBox(height: 8),
                          if (lugarData != null)
                            Text('${lugarData.parcelas}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          const Text(
                            'Parcelas disponibles',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(color: Colors.amber.shade600, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.build_circle, color: Colors.white, size: 36),
                          const SizedBox(height: 8),
                          if (lugarData != null)
                            Text('${lugarData.parcelasEnTratamiento}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          const Text(
                            'Parcela en tratamiento',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(color: Colors.red.shade600, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 36),
                          const SizedBox(height: 8),
                          if (lugarData != null)
                            Text('${lugarData.parcelasSinTratamiento}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          const Text(
                            'Parcelas sin tratamiento',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            
            // --- 2. Gráfico de Dona/Pie (Simulación) ---
            const Text('Progreso de Restauración (100% Base)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 20),
              // child: PieChart(...), // Aquí iría el widget fl_chart
              child: Center(
                child: Text('Gráfico de Dona aquí (Disponible vs. Pendiente)'),
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 3. Gráfico de Historial (Simulación) ---
            const Text('Historial de Biomasa y Vicuñas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 20),
              // child: LineChart(...), // Aquí iría el widget fl_chart
              child: Center(
                child: Text('Gráfico de Línea aquí (Biomasa/Vicuñas por Snapshot)'),
              ),
            ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ignore: unused_element
  Widget _buildKPICard({required String title, required String value, required String unit, required Color color, required IconData icon}) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(title, style: TextStyle(color: Colors.white70, fontSize: 13))),
                Icon(icon, color: Colors.white70),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                Text(unit, style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
