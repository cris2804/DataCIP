import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:cip/services/parcela_state_service.dart';
import 'package:cip/models/parcela_model.dart';

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
    final tappedParcel = parcelaService.parcels.lastWhere(
      (p) => _pointInPolygon(latLng, p.polygon.points),
      orElse: () => parcelaService.parcels.firstWhere((p) => false, orElse: () => null as Parcela),
    );

    if (tappedParcel != null) {
      // 1. Seleccionar la parcela
      selectedProvider.selectParcel(tappedParcel.id);
      // 2. Mover la lista a esa parcela
      final index = parcelaService.parcels.indexWhere((p) => p.id == tappedParcel.id);
      if (index != -1) {
        _itemScrollController.scrollTo(index: index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
      }
      // 3. Mostrar diálogo para cambiar estado
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
        return AlertDialog(
          title: Text('Cambiar Estado de Parcela ${parcela.id}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ParcelStatus.values.map((status) {
              return ListTile(
                title: Text(_statusToString(status)),
                leading: Radio<ParcelStatus>(
                  value: status,
                  groupValue: parcela.status,
                  onChanged: (ParcelStatus? value) {
                    if (value != null) {
                      context.read<ParcelaStateService>().updateParcelStatus(parcela.id, value);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                onTap: () {
                   context.read<ParcelaStateService>().updateParcelStatus(parcela.id, status);
                   Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          ],
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
      return Center(child: Text(parcelaService.error!, style: const TextStyle(color: Colors.red)));
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

    List<Polygon> polygonsToDraw = [if (parcelaService.boundary != null) parcelaService.boundary!];

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

      polygonsToDraw.add(Polygon(
        points: parcela.polygon.points,
        color: Colors.transparent, // Step 1: No fill, just testing borders
        borderStrokeWidth: isSelected ? 5.0 : 2.0, // Thicker borders
        borderColor: isSelected ? Colors.white : statusColor, // Border color now reflects status
      ));
    }

    // Create a key that is guaranteed to change when the status of any parcel changes.
    final String layerKey = parcelaService.parcels.map((p) => p.status.index).join();

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: const LatLng(-14.56, -69.79),
        zoom: 12.0,
        onTap: _onMapTap,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        PolygonLayer(key: ValueKey(layerKey), polygons: polygonsToDraw),
      ],
    );
  }

  Widget _buildParcelList(BuildContext context, ParcelaStateService parcelaService) {
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
          trailing: Icon(Icons.circle, color: _getColorForStatus(parcela.status).withOpacity(1)),
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
