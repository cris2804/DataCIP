import 'package:flutter/material.dart';
import '../services/calculo_service.dart';
import 'package:cip/services/biomasa_service.dart';
import 'package:cip/models/biomasa_dataset.dart';

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
  LugarBiomasa? _lugar;

  Future<void> _loadLugar() async {
    final ds = await BiomasaService.loadDataset();
    final byLugar = ds.asByLugar();
    final zl = widget.zona.toLowerCase();
    final key = (zl.contains('chalhuani') || zl.contains('challhuani')) ? 'challhuani' : 'tambokarka';
    setState(() {
      _lugar = byLugar[key] ?? byLugar['tambokarka'];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLugar();
  }

  void _calcular() {
  final int cantidad = int.tryParse(_controller.text) ?? 0;
    if (cantidad <= 0) {
      setState(() {
        _lastKpis = null;
        _message = 'Ingrese un número de parcelas válido (> 0).';
      });
      return;
    }

    // Construir configuración desde el JSON cargado
    final l = _lugar;
    if (l == null) {
      setState(() {
        _lastKpis = null;
        _message = 'No se pudo cargar los datos del lugar.';
      });
      return;
    }

    final Map<String, dynamic> config = {
      'area_por_parcela_m2': l.areaPorParcelaM2.toDouble(),
      'peso_fresco_m2_kg': l.freshWeightM2g / 1000.0, // g/m2 -> kg/m2
      'porcentaje_peso_seco': l.dryWeightPct / 100.0,
      'porcentaje_alimento_digerible': l.digestibleLeafPct / 100.0,
      'requerimiento_diario_vicuna_kg': l.idmsKgMsDia, // IDMS como requerimiento diario
      'dias_periodo': 30,
      'max_consumo_porcentaje': 0.30,
    };

    final service = CalculoService(config);
    final kpis = service.calcularKpis(cantidad);

    setState(() {
      _lastKpis = kpis;
      _message = 'Cálculo realizado exitosamente para $cantidad parcelas.';
    });
  }

  // Guardado de snapshot eliminado: no se requiere historial ni persistencia

  @override
  Widget build(BuildContext context) {
  // Sólo se mostrará el cálculo; no se listan datos del JSON

    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de Biomasa (${widget.zona})'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // No mostrar datos del JSON; sólo un pequeño indicador mientras carga
            if (_lugar == null)
              const Center(child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              )),
            const SizedBox(height: 8),
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _lugar == null ? null : _calcular,
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
                              title: const Text('Fresh weight total (kg)'),
                              trailing: Text('${_lastKpis!['fresh_weight_kg'].toStringAsFixed(3)} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            ListTile(
                              title: const Text('Biomasa disponible (kg)'),
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
            
            // Se removieron parámetros e historial
          ],
        ),
      ),
    );
  }

  // Eliminado: helper para filas de datos (no se muestran datos del JSON)
}
