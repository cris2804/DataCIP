import 'package:flutter/material.dart';
import 'package:cip/services/biomasa_service.dart';
import 'package:cip/models/biomasa_dataset.dart';
import 'package:fl_chart/fl_chart.dart';
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
            // Resolver alias de zona: tambokarka, challapalca/challhuani/variantes
            String key = 'tambokarka';
            if (byLugar.containsKey(zl)) {
              key = zl;
            } else if (zl.contains('chal')) {
              if (byLugar.containsKey('challapalca')) {
                key = 'challapalca';
              } else if (byLugar.containsKey('challhuani')) {
                key = 'challhuani';
              } else if (byLugar.containsKey('chalhuani')) {
                key = 'chalhuani';
              }
            }
            lugarData = byLugar[key] ?? byLugar.values.first;
          }
          return SingleChildScrollView(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // --- 1. Diseño tipo mockup: tarjeta superior con imagen de vicuña y fila de 3 cuadros coloreados ---
            // Tarjeta superior: Cantidad de Vicuñas (desde JSON) + imagen
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
                          const Text('Cantidad de vicuñas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Builder(
                            builder: (_) {
                              if (lugarData == null) {
                                return const Text('-', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo));
                              }
                              return Text('${lugarData.cantidadVicunas}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo));
                            },
                          ),
                          if (lugarData != null)
                            Text('Fuente: JSON', style: const TextStyle(fontSize: 12, color: Colors.black54)),
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
            
            // --- 2. Gráfico de Barras: Forraje Potencial vs. Disponible ---
            const Text('Forraje (kg) Potencial vs. Disponible', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 260,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: lugarData == null
                  ? const Center(child: Text('Sin datos'))
                  : _buildForrajeBarChart(lugarData),
            ),
            const SizedBox(height: 6),
            const Text('Forraje potencial: Biomasa del JSON (kg). Forraje disponible inicial: 0 kg (pastizales degradados).', style: TextStyle(fontSize: 12, color: Colors.black54)),
            
            const SizedBox(height: 20),

            // --- 3. Gráfico Circular: Progreso de restauración de pastizales ---
            const Text('Progreso de restauración de pastizales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 280,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: lugarData == null
                  ? const Center(child: Text('Sin datos'))
                  : _buildRestauracionPie(lugarData),
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

  // --- Charts helpers ---
  Widget _buildForrajeBarChart(LugarBiomasa l) {
    // Potencial = biomasa del JSON
    final double potencialKg = l.biomasaDisponible;
    // Disponible inicial = 0, pues todos los pastizales están degradados
    final double disponibleKg = 0.0;
    final maxY = (potencialKg > disponibleKg ? potencialKg : disponibleKg) * 1.2;

    Widget bottomTitle(double value, TitleMeta meta) {
      String text = '';
      if (value == 0) text = 'Potencial';
      if (value == 1) text = 'Disponible';
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 6,
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
    }

    return BarChart(
      BarChartData(
        maxY: maxY == 0 ? 1 : maxY,
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitle)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
        ),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: potencialKg, color: Colors.blue, width: 24)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: disponibleKg, color: Colors.green, width: 24)]),
        ],
      ),
    );
  }

  Widget _buildRestauracionPie(LugarBiomasa l) {
    final enTrat = l.parcelasEnTratamiento;
    final degrad = l.parcelasSinTratamiento;
    final resta = (l.parcelas - enTrat - degrad);
    final restaurada = resta < 0 ? 0 : resta;

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 0,
        sections: [
          PieChartSectionData(value: restaurada.toDouble(), title: 'Restaurada', color: Colors.green, titleStyle: const TextStyle(color: Colors.white, fontSize: 12)),
          PieChartSectionData(value: enTrat.toDouble(), title: 'Tratamiento', color: Colors.amber, titleStyle: const TextStyle(color: Colors.white, fontSize: 12)),
          PieChartSectionData(value: degrad.toDouble(), title: 'Degradado', color: Colors.red, titleStyle: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
