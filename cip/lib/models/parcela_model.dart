import 'package:flutter_map/flutter_map.dart';

enum ParcelStatus { sinTratamiento, enTratamiento, disponible }

class Parcela {
  final String id;
  final Polygon polygon;
  final Map<String, dynamic> properties;
  ParcelStatus status;

  Parcela({
    required this.id,
    required this.polygon,
    required this.properties,
    this.status = ParcelStatus.sinTratamiento, // Todas las parcelas inician como 'sin tratamiento'
  });
}
