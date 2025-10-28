import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cip/services/biomasa_service.dart';
import 'package:cip/models/biomasa_dataset.dart';
import 'package:cip/services/parcela_state_service.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  final String zona;

  const DashboardScreen({super.key, required this.zona});

  @override
  Widget build(BuildContext context) {
    // El servicio de parcelas ahora es la fuente de verdad para los contadores
    final parcelaService = Provider.of<ParcelaStateService>(context);

    return Scaffold(
      // El AppBar se movió a main.dart, por lo que se elimina de aquí
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
            String key = 'tambokarka';
            if (byLugar.containsKey(zl)) {
              key = zl;
            } else if (zl.contains('chal')) {
              key = 'challhuani';
            }
            lugarData = byLugar[key] ?? byLugar.values.first;
          }
          return SingleChildScrollView(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Cantidad de vicuñas',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${lugarData?.cantidadVicunas ?? '-'}',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              if (lugarData != null)
                                const Text(
                                  ' ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/vicuna.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.pets, size: 64),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Fila de 3 cuadros coloreados AHORA CONECTADOS AL PARCELASTATESERVICE
                Row(
                  children: [
                    _buildStatusCard(
                      context,
                      color: Colors.green.shade600,
                      icon: Icons.terrain,
                      title: 'Disponibles',
                      value: parcelaService.disponibleCount,
                    ),
                    _buildStatusCard(
                      context,
                      color: Colors.amber.shade600,
                      icon: Icons.build_circle,
                      title: 'En Tratamiento',
                      value: parcelaService.enTratamientoCount,
                    ),
                    _buildStatusCard(
                      context,
                      color: Colors.red.shade600,
                      icon: Icons.warning_amber_rounded,
                      title: 'Degradado',
                      value: parcelaService.sinTratamientoCount,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  'Forraje (kg) Progreso vs. Potencial',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 260,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: lugarData == null
                      ? const Center(child: Text('Sin datos'))
                      : _buildBiomasaLineChart(lugarData, parcelaService),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Forraje potencial: Biomasa del JSON (kg). Forraje disponible inicial: 0 kg (pastizales degradados).',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Progreso de restauración de pastizales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 280,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _buildRestauracionPie(parcelaService),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context, {
    required Color color,
    required IconData icon,
    required String title,
    required int value,
  }) {
    return Expanded(
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(
                '$value',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBiomasaLineChart(
    LugarBiomasa l,
    ParcelaStateService parcelaService,
  ) {
    // Potencial = biomasa del JSON
    final double potencialKg = l.biomasaDisponible;

    // Disponible actual en función de parcelas disponibles
    final double forrajePorParcela = parcelaService.parcels.isNotEmpty
        ? potencialKg / parcelaService.parcels.length
        : 0;
    final double disponibleActualKg =
        forrajePorParcela * parcelaService.disponibleCount;

    // Serie mensual (12 meses): desde 0 (inicio degradado) hasta alcanzar la meta.
    // Pasando por el valor actual de biomasa disponible en el mes en curso.
    const int nMeses = 12; // Eje X en meses
    final int mesActualIdx = DateTime.now().month - 1; // 0..11
    final List<FlSpot> progreso = List.generate(nMeses, (i) {
      double y;
      if (mesActualIdx <= 0) {
        // Si estamos en enero (idx 0), empezamos en 0 y luego proyectamos al resto del año
        if (i == 0) {
          y = 0;
        } else {
          y =
              disponibleActualKg +
              (potencialKg - disponibleActualKg) * (i / 11);
        }
      } else {
        if (i <= mesActualIdx) {
          // Interpola 0 -> disponibleActualKg en los meses pasados del año
          y = disponibleActualKg * (i / mesActualIdx);
        } else {
          // Proyección: desde disponibleActualKg hasta potencial al final del año
          final remaining = 11 - mesActualIdx;
          final t = (i - mesActualIdx) / (remaining == 0 ? 1 : remaining);
          y = disponibleActualKg + (potencialKg - disponibleActualKg) * t;
        }
      }
      if (y < 0) y = 0; // seguridad
      if (y > potencialKg) y = potencialKg; // no pasar el potencial
      return FlSpot(i.toDouble(), y);
    });

    // Línea horizontal (potencial) como referencia punteada
    final List<FlSpot> potencialSerie = List.generate(
      nMeses,
      (i) => FlSpot(i.toDouble(), potencialKg),
    );

    final maxY =
        (potencialKg > disponibleActualKg ? potencialKg : disponibleActualKg) *
        1.2;

    String yLabel(double v) {
      if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}K';
      return v.toStringAsFixed(0);
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (nMeses - 1).toDouble(),
        minY: 0,
        maxY: maxY == 0 ? 1 : maxY,
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const meses = [
                  'Ene',
                  'Feb',
                  'Mar',
                  'Abr',
                  'May',
                  'Jun',
                  'Jul',
                  'Ago',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dic',
                ];
                final idx = value.toInt();
                final label = (idx >= 0 && idx < meses.length)
                    ? meses[idx]
                    : '';
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(label, style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  yLabel(value),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: progreso,
            isCurved: true,
            barWidth: 3,
            color: Colors.green,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.withOpacity(0.15),
            ),
          ),
          LineChartBarData(
            spots: potencialSerie,
            isCurved: false,
            barWidth: 2,
            color: Colors.blueGrey,
            dashArray: [6, 4],
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  Widget _buildRestauracionPie(ParcelaStateService parcelaService) {
    final sinTrat = parcelaService.sinTratamientoCount.toDouble();
    final enTrat = parcelaService.enTratamientoCount.toDouble();
    final disponible = parcelaService.disponibleCount.toDouble();

    if (parcelaService.parcels.isEmpty) {
      return const Center(child: Text('No hay datos de parcelas'));
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: disponible,
            title: '${disponible.toInt()}\nDisp.',
            color: Colors.green,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            value: enTrat,
            title: '${enTrat.toInt()}\nTrat.',
            color: Colors.amber,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            value: sinTrat,
            title: '${sinTrat.toInt()}\nS/Trat.',
            color: Colors.red,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
