import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaScreen extends StatefulWidget {
  final String zona;

  const MapaScreen({super.key, required this.zona});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  List<Polygon> _polygons = [];
  List<Polygon> _rectangles = [];
  LatLng _center = LatLng(-14.5463, -69.7837); // valor por defecto cercano a tu GeoJSON
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadGeoJson();
  }

  Future<void> _loadGeoJson() async {
    try {
      final raw = await rootBundle.loadString('assets/data/parcelas.json');
      final Map<String, dynamic> data = jsonDecode(raw);
      final features = data['features'] as List<dynamic>? ?? [];

      final List<Polygon> polygons = [];
      final List<Polygon> rectangles = [];

      for (final f in features) {
        final geom = f['geometry'] as Map<String, dynamic>?;
        if (geom == null) continue;
        final type = geom['type'];
        if (type == 'Polygon') {
          final coords = geom['coordinates'] as List<dynamic>;
          if (coords.isEmpty) continue;
          // Usamos el primer anillo
          final ring = coords[0] as List<dynamic>;
          final List<LatLng> latlngs = [];
          double? minLat, minLng, maxLat, maxLng;

          for (final pair in ring) {
            if (pair is List && pair.length >= 2) {
              final double lon = (pair[0] as num).toDouble();
              final double lat = (pair[1] as num).toDouble();
              latlngs.add(LatLng(lat, lon));

              minLat = (minLat == null) ? lat : (lat < minLat ? lat : minLat);
              minLng = (minLng == null) ? lon : (lon < minLng ? lon : minLng);
              maxLat = (maxLat == null) ? lat : (lat > maxLat ? lat : maxLat);
              maxLng = (maxLng == null) ? lon : (lon > maxLng ? lon : maxLng);
            }
          }

          if (latlngs.isNotEmpty) {
            polygons.add(
              Polygon(
                points: latlngs,
                borderColor: Colors.green.shade700,
                color: Colors.green.withOpacity(0.2),
                borderStrokeWidth: 2.0,
              ),
            );

            if (minLat != null && minLng != null && maxLat != null && maxLng != null) {
              final rect = [
                LatLng(minLat, minLng),
                LatLng(minLat, maxLng),
                LatLng(maxLat, maxLng),
                LatLng(maxLat, minLng),
              ];
              rectangles.add(
                Polygon(
                  points: rect,
                  borderColor: Colors.red.shade700,
                  color: Colors.transparent,
                  borderStrokeWidth: 2.0,
                ),
              );

              // Generar malla de celdas de 50x50 metros dentro del polígono
              const double cellSizeMeters = 50.0;
              final parcels = _generateGridParcels(
                minLat: minLat,
                minLng: minLng,
                maxLat: maxLat,
                maxLng: maxLng,
                cellSizeMeters: cellSizeMeters,
                polygonPts: latlngs,
              );

              for (final p in parcels) {
                // usar color semitransparente para las parcelas
                polygons.add(
                  Polygon(
                    points: p,
                    borderColor: Colors.blue.shade800,
                    color: Colors.blue.withOpacity(0.25),
                    borderStrokeWidth: 0.5,
                  ),
                );
              }

              // Ajustar centro al primer feature si estamos en estado inicial
              if (mounted && _loading) {
                _center = LatLng((minLat + maxLat) / 2.0, (minLng + maxLng) / 2.0);
              }
            }
          }
        }
      }

      setState(() {
        _polygons = polygons;
        _rectangles = rectangles;
        _loading = false;
      });
    } catch (e) {
      // Si falla, mostramos un mensaje y dejamos _loading false
      debugPrint('Error cargando GeoJSON: $e');
      setState(() => _loading = false);
    }
  }

  // Genera una lista de rectángulos (cada uno como List<LatLng>) de tamaño aproximado cellSizeMeters x cellSizeMeters
  // y devuelve solo aquellos cuyo centro cae dentro del polígono original.
  List<List<LatLng>> _generateGridParcels({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
    required double cellSizeMeters,
    required List<LatLng> polygonPts,
  }) {
    // Aproximación: 1 grado lat ≈ 111320 metros
    const double metersPerDegLat = 111320.0;

    final List<List<LatLng>> parcels = [];

    // Altura en grados para una celda de cellSizeMeters
    final double dLat = cellSizeMeters / metersPerDegLat;

    // Para longitud necesitamos ajustar por latitud: meters per deg lon = metersPerDegLat * cos(lat)
    // Usaremos la latitud media del bounding box para calcular dLon
    
    // Iterar filas y columnas
    for (double lat = minLat; lat < maxLat; lat += dLat) {
      // recalcular dLon para la lat actual para mayor precisión
  final double metersPerDegLon = metersPerDegLat * (math.cos(lat * math.pi / 180.0));
      final double dLon = cellSizeMeters / metersPerDegLon;

      for (double lon = minLng; lon < maxLng; lon += dLon) {
        final List<LatLng> cell = [
          LatLng(lat, lon),
          LatLng(lat, lon + dLon),
          LatLng(lat + dLat, lon + dLon),
          LatLng(lat + dLat, lon),
        ];

        // centro de la celda
        final LatLng center = LatLng(lat + dLat / 2.0, lon + dLon / 2.0);

        if (_pointInPolygon(center, polygonPts)) {
          parcels.add(cell);
        }
      }
    }

    return parcels;
  }

  // Test de punto-en-polígono: algoritmo ray-casting
  bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
    final int n = polygon.length;
    bool inside = false;
    for (int i = 0, j = n - 1; i < n; j = i++) {
      final double xi = polygon[i].longitude, yi = polygon[i].latitude;
      final double xj = polygon[j].longitude, yj = polygon[j].latitude;

      final bool intersect = ((yi > point.latitude) != (yj > point.latitude)) &&
          (point.longitude < (xj - xi) * (point.latitude - yi) / (yj - yi + 0.0) + xi);
      if (intersect) inside = !inside;
    }
    return inside;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa y Edición (${widget.zona})'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Lógica para exportar GeoJSON actualizado
            },
            tooltip: 'Exportar GeoJSON',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _center,
                zoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.cip',
                ),
                if (_polygons.isNotEmpty)
                  PolygonLayer(polygons: _polygons),
                if (_rectangles.isNotEmpty)
                  PolygonLayer(polygons: _rectangles),
              ],
            ),
    );
  }
}
