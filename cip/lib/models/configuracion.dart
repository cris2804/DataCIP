import 'dart:convert';
import 'package:isar/isar.dart';

part 'configuracion.g.dart';

@collection
class Configuracion {
  // Id fijo para que solo exista una fila de configuración global
  Id isarId = 1; 

  // Configuración global
  String pin; // Pin de bloqueo (Ej: '1234')

  // Mapeo de configuraciones por zona
  // Se usa Map<String, ConfigZona> si Isar lo soportara directamente, 
  // pero para Isar, es mejor guardar la configuración serializada o en clases separadas.
  
  // Simplificamos: Guardamos la configuración de ambas zonas juntas en JSON (string)
  String tambokarkaJson;
  String challhuaniJson;

  Configuracion({
    this.pin = '1234',
    required this.tambokarkaJson,
    required this.challhuaniJson,
  });

  // Getter para obtener el objeto de configuración de la zona activa
  Map<String, dynamic> getZoneConfig(String zoneName) {
    if (zoneName == 'Tambokarka') {
      return Map<String, dynamic>.from(json.decode(tambokarkaJson));
    } else if (zoneName == 'Challhuani') {
      return Map<String, dynamic>.from(json.decode(challhuaniJson));
    }
    return {};
  }
}
// NOTA: Para usar json.decode/encode se requiere importar dart:convert
