import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import '../models/parcela_model.dart';

class ParcelaStateService extends ChangeNotifier {
  List<Parcela> parcels = [];
  Polygon? boundary;
  bool isLoading = true;
  String? error;

  int get sinTratamientoCount => parcels.where((p) => p.status == ParcelStatus.sinTratamiento).length;
  int get enTratamientoCount => parcels.where((p) => p.status == ParcelStatus.enTratamiento).length;
  int get disponibleCount => parcels.where((p) => p.status == ParcelStatus.disponible).length;

  Future<void> loadDataForZone(String zone) async {
    try {
      isLoading = true;
      notifyListeners();

      final String boundaryAsset;
      final String parcelsAsset;

      if (zone.toLowerCase() == 'challhuani') {
        boundaryAsset = 'assets/data/parcelas.json';
        parcelsAsset = 'assets/data/jsonchal.json';
      } else {
        boundaryAsset = 'assets/data/fomra_tam.json';
        parcelsAsset = 'assets/data/jsontam.json';
      }

      final projSrc = proj4.Projection.add(
        'EPSG:32719',
        '+proj=utm +zone=19 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
      );
      final projDst = proj4.Projection.get('EPSG:4326')!;

      final boundaryRaw = await rootBundle.loadString(boundaryAsset);
      final boundaryData = jsonDecode(boundaryRaw);
      final boundaryFeature = boundaryData['features'][0];
      final boundaryCoords = boundaryFeature['geometry']['coordinates'][0] as List;
      final boundaryPoints = boundaryCoords.map((p) => LatLng(p[1], p[0])).toList();
      boundary = Polygon(
        points: boundaryPoints,
        borderColor: Colors.red.shade700,
        color: Colors.transparent,
        borderStrokeWidth: 3.0,
      );

      final parcelsRaw = await rootBundle.loadString(parcelsAsset);
      final parcelsData = jsonDecode(parcelsRaw);
      final parcelFeatures = (parcelsData['features'] as List);

      final List<Parcela> loadedParcels = [];
      for (var feature in parcelFeatures) {
        final properties = feature['properties'] as Map<String, dynamic>;
        final id = properties['FID'].toString();
        
        var coords = feature['geometry']['coordinates'][0] as List;
        if (coords.isNotEmpty && coords[0] is List && (coords[0] as List).isNotEmpty && (coords[0] as List)[0] is List) {
          coords = coords[0] as List;
        }
        
        final List<LatLng> parcelPoints = [];
        for (var p in coords) {
          if (p is List && p.length >= 2 && p[0] is num && p[1] is num) {
            final point = proj4.Point(x: (p[0] as num).toDouble(), y: (p[1] as num).toDouble());
            final wgs84Point = projSrc.transform(projDst, point);
            parcelPoints.add(LatLng(wgs84Point.y, wgs84Point.x));
          }
        }

        if (parcelPoints.isNotEmpty) {
          loadedParcels.add(Parcela(
            id: id,
            properties: properties,
            polygon: Polygon(
              points: parcelPoints,
              borderColor: Colors.blue.shade800,
              color: Colors.blue.withOpacity(0.25),
              borderStrokeWidth: 1.0,
            ),
          ));
        }
      }
      parcels = loadedParcels;
      error = null;
    } catch (e) {
      error = 'Error cargando datos para $zone: $e';
      debugPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateParcelStatus(String parcelId, ParcelStatus newStatus) {
    final index = parcels.indexWhere((p) => p.id == parcelId);
    if (index != -1) {
      parcels[index].status = newStatus;
      notifyListeners();
    }
  }
}
