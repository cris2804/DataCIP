import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:fl_chart/fl_chart.dart'; // Para gráficos

class DashboardScreen extends StatelessWidget {
  final String zona;
  
  const DashboardScreen({super.key, required this.zona});

  // Simulación de datos de KPI (en Flutter real, se tomarían del provider)
  final double pctDisponible = 30.2;
  final int parcelasDisponibles = 394;
  final int vicunasAlimentadas = 5200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Indicadores ($zona)'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Tarjetas de KPIs (Adaptación de CardKPI) ---
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildKPICard(
                  title: 'Vicuñas Alimentadas',
                  value: '$vicunasAlimentadas',
                  unit: 'Máx. 30% consumo',
                  color: Colors.red.shade600,
                  icon: Icons.grass_outlined,
                ),
                _buildKPICard(
                  title: 'Potencial Total',
                  value: '1306',
                  unit: '100%',
                  color: Colors.grey.shade700,
                  icon: Icons.flash_on,
                ),
                _buildKPICard(
                  title: 'Disponible (Restaurado)',
                  value: '$parcelasDisponibles',
                  unit: '${pctDisponible}%',
                  color: Colors.green.shade600,
                  icon: Icons.check_circle_outline,
                ),
                _buildKPICard(
                  title: 'Esperado (Falta Finalizar)',
                  value: '912', // 1306 - 394
                  unit: '${(100 - pctDisponible).toStringAsFixed(1)}%',
                  color: Colors.amber.shade600,
                  icon: Icons.access_time,
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
      ),
    );
  }

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
