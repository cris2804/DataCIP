import 'package:flutter_map/flutter_map.dart';

enum ParcelStatus { sinTratamiento, enTratamiento, disponible }

class Parcela {
  final String id;
  final Polygon polygon;
  final Map<String, dynamic> properties;
  ParcelStatus status;

  // Metadatos de monitoreo
  DateTime? fecha;
  String observacion;
  String supervisor;
  List<String> fotos; // rutas locales

  Parcela({
    required this.id,
    required this.polygon,
    required this.properties,
    this.status = ParcelStatus.sinTratamiento,
    this.fecha,
    this.observacion = '',
    this.supervisor = '',
    this.fotos = const [],
  });
}
