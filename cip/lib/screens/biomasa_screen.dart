import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../services/calculo_service.dart';
// import '../providers/pasto_control_provider.dart';

class BiomasaScreen extends StatefulWidget {
  final String zona;
  const BiomasaScreen({super.key, required this.zona});

  @override
  State<BiomasaScreen> createState() => _BiomasaScreenState();
}

class _BiomasaScreenState extends State<BiomasaScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _lastKpis;
  String _message = '';

  void _calcular() {
    final int cantidad = int.tryParse(_controller.text) ?? 0;
    if (cantidad <= 0) {
      setState(() {
        _lastKpis = null;
        _message = 'Ingrese un número de parcelas válido (> 0).';
      });
      return;
    }

    // En una app real, obtendrías la configuración activa del Provider
    // Simulamos la configuración de Tambokarka
    final Map<String, dynamic> configSimulada = {
      'area_por_parcela_m2': 2500.0,
      'peso_fresco_m2_kg': 0.166777778,
      'porcentaje_peso_seco': 0.78,
      'porcentaje_alimento_digerible': 0.77,
      'requerimiento_diario_vicuna_kg': 1.0,
      'dias_periodo': 30,
      'max_consumo_porcentaje': 0.30,
    };
    
    final service = CalculoService(configSimulada);
    final kpis = service.calcularKpis(cantidad);

    setState(() {
      _lastKpis = kpis;
      _message = 'Cálculo realizado exitosamente para $cantidad parcelas.';
    });
  }

  void _guardarSnapshot() {
    if (_lastKpis == null) {
      setState(() {
        _message = 'Debe calcular la biomasa antes de guardar el snapshot.';
      });
      return;
    }
    
    final int cantidad = int.tryParse(_controller.text) ?? 0;
    // final provider = Provider.of<PastoControlProvider>(context, listen: false);
    
    // provider.saveSnapshot(Snapshot(
    //   zona: widget.zona,
    //   fecha: DateTime.now(),
    //   cantidadParcelas: cantidad,
    //   biomasaKg: _lastKpis!['biomasa_disponible_kg'],
    //   vicunasAlimentadas: _lastKpis!['vicunas_alimentadas'],
    //   notas: 'Cálculo manual de ${widget.zona}',
    // ));

    setState(() {
      _message = 'Snapshot de biomasa de ${widget.zona} guardado con éxito.';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Simulación de parámetros activos
    const req = 1.0;
    const dias = 30;
    const maxConsumo = 30;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de Biomasa ($widget.zona)'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Inputs y Cálculo ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cantidad de Parcelas a Analizar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Ingrese número de parcelas',
                        suffixIcon: const Icon(Icons.numbers),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _calcular,
                            icon: const Icon(Icons.bolt),
                            label: const Text('Calcular'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _lastKpis != null ? _guardarSnapshot : null,
                            icon: const Icon(Icons.save),
                            label: const Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(_message, style: TextStyle(color: _lastKpis != null ? Colors.blue : Colors.red, fontSize: 14)),
                      ),
                    
                    if (_lastKpis != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Resultados:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ListTile(
                              title: const Text('Biomasa Disponible Total (kg)'),
                              trailing: Text('${_lastKpis!['biomasa_disponible_kg'].toStringAsFixed(3)} kg', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            ),
                            ListTile(
                              title: const Text('Vicuñas Alimentadas (Entero)'),
                              trailing: Text('${_lastKpis!['vicunas_alimentadas']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // --- Parámetros Activos ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Parámetros Activos del Periodo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ListTile(title: const Text('Req. Diario Vicuña (kg MS/día)'), trailing: Text('$req')),
                    ListTile(title: const Text('Días del Periodo'), trailing: Text('$dias días')),
                    ListTile(title: const Text('Límite de Consumo de Vicuñas'), trailing: Text('$maxConsumo%')),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // --- Historial (Simulación) ---
            const Text('Historial de Snapshots (Simulación)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // Aquí iría el ListView.builder para mostrar el historial de la DB
          ],
        ),
      ),
    );
  }
}
