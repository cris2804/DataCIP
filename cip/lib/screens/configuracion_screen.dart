import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class ConfiguracionScreen extends StatefulWidget {
  final String zona;
  const ConfiguracionScreen({super.key, required this.zona});

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  bool _isLocked = true;
  String _pinInput = '';
  String _pinMessage = 'Bloqueado. Ingrese el PIN para editar.';
  // Simulación de PIN y Configuración
  final String _pinMaster = '1234';

  // Controladores para la configuración activa (simulados)
  late TextEditingController _reqController;
  late TextEditingController _diasController;
  late TextEditingController _pesoFrescoController;

  @override
  void initState() {
    super.initState();
    // Valores simulados iniciales de Tambokarka
    _reqController = TextEditingController(text: '1.0');
    _diasController = TextEditingController(text: '30');
    _pesoFrescoController = TextEditingController(text: '0.16677');
  }

  void _toggleLock() {
    if (_isLocked) {
      if (_pinInput == _pinMaster) {
        setState(() {
          _isLocked = false;
          _pinInput = '';
          _pinMessage = 'Desbloqueado. Los parámetros son editables.';
        });
      } else {
        setState(() {
          _pinMessage = 'PIN incorrecto. Intente de nuevo.';
        });
      }
    } else {
      setState(() {
        _isLocked = true;
        _pinMessage = 'Bloqueado. Ingrese el PIN para editar.';
      });
    }
  }

  void _guardarCambios() {
    // Lógica para guardar la configuración actualizada de la zona activa en Isar/Provider
    // final provider = Provider.of<PastoControlProvider>(context, listen: false);
    // provider.updateConfiguracion(widget.zona, { ... nuevos valores ... });

    setState(() {
      _pinMessage = 'Configuración de ${widget.zona} guardada con éxito.';
      _isLocked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion ($widget.zona)'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Bloqueo/Desbloqueo PIN ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Protección con PIN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isLocked ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => _pinInput = value,
                            obscureText: _isLocked,
                            enabled: _isLocked,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: _isLocked
                                  ? 'Ingrese PIN'
                                  : 'Parámetros Editables',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: _toggleLock,
                          icon: Icon(
                            _isLocked ? Icons.lock_open : Icons.lock,
                            color: Colors.white,
                          ),
                          label: Text(
                            _isLocked ? 'Desbloquear' : 'Bloquear',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLocked
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    if (_pinMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _pinMessage,
                          style: TextStyle(
                            color: _isLocked ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Formulario de Configuración ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parámetros Específicos de ${widget.zona}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Ejemplo de campo editable
                    TextField(
                      controller: _pesoFrescoController,
                      enabled: !_isLocked,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Peso Fresco (kg/m²)',
                        helperText:
                            'Parámetro fijo, editable por técnico principal',
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: _reqController,
                      enabled: !_isLocked,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Req. Diario Vicuña (kg MS/día)',
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: _diasController,
                      enabled: !_isLocked,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Días del Periodo',
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: !_isLocked ? _guardarCambios : null,
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: Text(
                        'Guardar Cambios de ${widget.zona}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
