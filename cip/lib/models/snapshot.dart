import 'package:isar/isar.dart';

part 'snapshot.g.dart';

@collection
class Snapshot {
  Id id = Isar.autoIncrement;

  @Index()
  String zona; // Tambokarka o Challhuani

  DateTime fecha;
  int cantidadParcelas;
  double biomasaKg;
  int vicunasAlimentadas;
  String notas;

  Snapshot({
    required this.zona,
    required this.fecha,
    required this.cantidadParcelas,
    required this.biomasaKg,
    required this.vicunasAlimentadas,
    this.notas = '',
  });
}
