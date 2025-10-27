import 'package:isar/isar.dart';

part 'parcela.g.dart';

// Definimos la Parcela (Simulando las propiedades GeoJSON)
@collection
class Parcela {
  // La clave (id) debe ser nullable (Id?) para usar autoIncrement
  // y debe ser un campo editable para que Isar lo maneje correctamente.
  Id id = Isar.autoIncrement; // Usar Isar.autoIncrement para IDs válidos en la web

  @Index(unique: true, replace: true)
  String parcelaId; // Ej: TBK_0001 (Usado como ID visible)

  String estado; // 'restaurado', 'en_proceso', 'iniciado', 'pendiente'
  DateTime fechaEstado;
  String observaciones;
  List<String> fotos; // Rutas locales
  
  // Coordenadas o GeoJSON (en una app real sería un String con el geojsonFeature)
  String geojsonFeature; 

  Parcela({
    required this.parcelaId,
    required this.estado,
    required this.fechaEstado,
    this.observaciones = '',
    this.fotos = const [],
    this.geojsonFeature = '',
  });

  // Método de conveniencia para actualizar el estado
  Parcela copyWith({
    String? estado,
    DateTime? fechaEstado,
    String? observaciones,
  }) {
    return Parcela(
      parcelaId: this.parcelaId,
      estado: estado ?? this.estado,
      fechaEstado: fechaEstado ?? this.fechaEstado,
      observaciones: observaciones ?? this.observaciones,
      fotos: this.fotos,
      geojsonFeature: this.geojsonFeature,
    )..id = this.id; // Mantener el ID existente
  }
}
