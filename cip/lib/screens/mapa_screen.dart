import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:cip/services/parcela_state_service.dart';
import 'package:cip/models/parcela_model.dart';
import 'package:image_picker/image_picker.dart';

// Provider para el estado local de la UI del mapa (parcela seleccionada)
class SelectedParcelProvider extends ChangeNotifier {
  String? _selectedParcelId;
  String? get selectedParcelId => _selectedParcelId;

  void selectParcel(String? parcelId) {
    if (_selectedParcelId != parcelId) {
      _selectedParcelId = parcelId;
      notifyListeners();
    }
  }
}

class MapaScreen extends StatelessWidget {
  final String zona;
  const MapaScreen({super.key, required this.zona});

  @override
  Widget build(BuildContext context) {
    // Este provider es local para esta pantalla, para manejar la selección
    return ChangeNotifierProvider(
      create: (_) => SelectedParcelProvider(),
      child: _MapaScreenContent(zona: zona),
    );
  }
}

class _MapaScreenContent extends StatefulWidget {
  final String zona;
  const _MapaScreenContent({required this.zona});

  @override
  State<_MapaScreenContent> createState() => _MapaScreenContentState();
}

class _MapaScreenContentState extends State<_MapaScreenContent> {
  final MapController _mapController = MapController();
  final ItemScrollController _itemScrollController = ItemScrollController();

  // --- Lógica de Interacción ---

  void _onMapTap(TapPosition pos, LatLng latLng) {
    final parcelaService = context.read<ParcelaStateService>();
    final selectedProvider = context.read<SelectedParcelProvider>();

    // Buscar la parcela presionada (de la última a la primera)
    Parcela? tappedParcel;
    for (final p in parcelaService.parcels.reversed) {
      if (_pointInPolygon(latLng, p.polygon.points)) {
        tappedParcel = p;
        break;
      }
    }

    if (tappedParcel != null) {
      // 1. Seleccionar la parcela
      selectedProvider.selectParcel(tappedParcel.id);
      // 2. Mover la lista a esa parcela
      final index = parcelaService.parcels.indexWhere(
        (p) => p.id == tappedParcel!.id,
      );
      if (index != -1) {
        _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
      // 3. Mostrar diálogo para actualizar
      _showStatusChangeDialog(tappedParcel);
    }
  }

  bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length - 1; j++) {
      if (_rayCastIntersect(point, polygon[j], polygon[j + 1])) {
        intersectCount++;
      }
    }
    return (intersectCount % 2) == 1; // odd = inside, even = outside
  }

  bool _rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }

    double m = (aY - bY) / (aX - bX);
    double bee = (-aX) * m + aY;
    double x = (pY - bee) / m;

    return x > pX;
  }

  void _showStatusChangeDialog(Parcela parcela) {
    showDialog(
      context: context,
      builder: (context) {
        // Estado local del formulario
        ParcelStatus selected = parcela.status;
        DateTime fecha = parcela.fecha ?? DateTime.now();
        final TextEditingController obsCtrl = TextEditingController(
          text: parcela.observacion,
        );
        final TextEditingController supCtrl = TextEditingController(
          text: parcela.supervisor,
        );
        List<String> fotos = List.of(parcela.fotos);

        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> pickPhotos() async {
              final ImagePicker picker = ImagePicker();
              final images = await picker.pickMultiImage(maxWidth: 2048);
              if (images.isNotEmpty) {
                setState(() => fotos.addAll(images.map((e) => e.path)));
              }
            }

            return AlertDialog(
              title: Text('Actualizar Parcela ${parcela.id}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Estado del pastizal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...ParcelStatus.values.map(
                      (status) => RadioListTile<ParcelStatus>(
                        dense: true,
                        title: Text(_statusToString(status)),
                        value: status,
                        groupValue: selected,
                        onChanged: (v) => setState(() => selected = v!),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Fecha: '),
                        TextButton.icon(
                          icon: const Icon(Icons.event),
                          label: Text(
                            '${fecha.day}/${fecha.month}/${fecha.year}',
                          ),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: fecha,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) setState(() => fecha = picked);
                          },
                        ),
                      ],
                    ),
                    TextField(
                      controller: supCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Supervisor',
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: obsCtrl,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Observación',
                        prefixIcon: Icon(Icons.notes),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: pickPhotos,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Agregar fotos'),
                        ),
                        const SizedBox(width: 8),
                        Text('${fotos.length} foto(s)'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                  onPressed: () {
                    context.read<ParcelaStateService>().updateParcelData(
                      parcelId: parcela.id,
                      status: selected,
                      fecha: fecha,
                      observacion: obsCtrl.text,
                      supervisor: supCtrl.text,
                      fotosAppend: fotos,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _statusToString(ParcelStatus status) {
    switch (status) {
      case ParcelStatus.disponible:
        return 'Disponible';
      case ParcelStatus.enTratamiento:
        return 'En Tratamiento';
      case ParcelStatus.sinTratamiento:
        return 'Degradado';
    }
  }

  Color _getColorForStatus(ParcelStatus status) {
    switch (status) {
      case ParcelStatus.disponible:
        return Colors.green;
      case ParcelStatus.enTratamiento:
        return Colors.amber;
      case ParcelStatus.sinTratamiento:
        return Colors.red;
    }
  }

  // --- Widgets de Construcción ---

  @override
  Widget build(BuildContext context) {
    final parcelaService = context.watch<ParcelaStateService>();

    if (parcelaService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (parcelaService.error != null) {
      return Center(
        child: Text(
          parcelaService.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return Column(
      children: [
        Expanded(flex: 1, child: _buildMap(context, parcelaService)),
        Expanded(flex: 1, child: _buildParcelList(context, parcelaService)),
      ],
    );
  }

  Widget _buildMap(BuildContext context, ParcelaStateService parcelaService) {
    final selectedId = context.watch<SelectedParcelProvider>().selectedParcelId;

    List<Polygon> polygonsToDraw = [
      if (parcelaService.boundary != null) parcelaService.boundary!,
    ];

    for (var parcela in parcelaService.parcels) {
      final isSelected = parcela.id == selectedId;

      Color statusColor;
      switch (parcela.status) {
        case ParcelStatus.disponible:
          statusColor = Colors.green;
          break;
        case ParcelStatus.enTratamiento:
          statusColor = Colors.yellow;
          break;
        case ParcelStatus.sinTratamiento:
          statusColor = Colors.red;
          break;
      }

      polygonsToDraw.add(
        Polygon(
          points: parcela.polygon.points,
          color: Colors.transparent, // solo borde
          borderStrokeWidth: isSelected ? 5.0 : 2.0,
          borderColor: isSelected ? Colors.white : statusColor,
        ),
      );
    }

    // Clave que cambia si cambia el estado
    final String layerKey = parcelaService.parcels
        .map((p) => p.status.index)
        .join();

    // Centro inicial: si hay límite, usar centroide
    LatLng initialCenter = const LatLng(-14.56, -69.79);
    if (parcelaService.boundary != null &&
        parcelaService.boundary!.points.isNotEmpty) {
      initialCenter = _centroid(parcelaService.boundary!.points);
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: initialCenter,
            initialZoom: 14.0, // más zoom para enfocar mejor el área
            onTap: _onMapTap,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            PolygonLayer(key: ValueKey(layerKey), polygons: polygonsToDraw),
          ],
        ),
        Positioned(left: 12, bottom: 12, child: _buildLegend()),
      ],
    );
  }

  // Centroide simple (promedio de puntos)
  LatLng _centroid(List<LatLng> pts) {
    double lat = 0, lng = 0;
    for (final p in pts) {
      lat += p.latitude;
      lng += p.longitude;
    }
    final n = pts.isEmpty ? 1 : pts.length;
    return LatLng(lat / n, lng / n);
  }

  Widget _buildLegend() {
    Widget entry(Color c, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leyenda',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 6),
            entry(Colors.green, 'Disponible'),
            const SizedBox(height: 4),
            entry(Colors.amber, 'En tratamiento'),
            const SizedBox(height: 4),
            entry(Colors.red, 'Degradado'),
          ],
        ),
      ),
    );
  }

  Widget _buildParcelList(
    BuildContext context,
    ParcelaStateService parcelaService,
  ) {
    final selectedProvider = context.watch<SelectedParcelProvider>();

    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: parcelaService.parcels.length,
      itemBuilder: (context, index) {
        final parcela = parcelaService.parcels[index];
        final isSelected = parcela.id == selectedProvider.selectedParcelId;
        return ListTile(
          tileColor: isSelected ? Colors.blue.withOpacity(0.2) : null,
          title: Text('Parcela ID: ${parcela.properties['FID']}'),
          subtitle: Text('Estado: ${_statusToString(parcela.status)}'),
          trailing: Icon(
            Icons.circle,
            color: _getColorForStatus(parcela.status).withOpacity(1),
          ),
          onTap: () {
            context.read<SelectedParcelProvider>().selectParcel(parcela.id);
            _showStatusChangeDialog(parcela);
          },
        );
      },
    );
  }
}

// Se necesita agregar la dependencia `scrollable_positioned_list` a pubspec.yaml
// Se necesita agregar la dependencia `scrollable_positioned_list` a pubspec.yaml
