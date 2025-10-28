import 'dart:convert';

class LugarBiomasa {
  final String lugar;
  final int parcelas;
  final int parcelasEnTratamiento;
  final int parcelasSinTratamiento;
  final int areaPorParcelaM2;
  final double freshWeightM2g;
  final double freshWeightKg;
  final double dryWeightPct;
  final double digestibleLeafPct;
  final double biomasaDisponible;
  final double idmsKgMsDia;
  final int cantidadVicunas;

  const LugarBiomasa({
    required this.lugar,
    required this.parcelas,
    this.parcelasEnTratamiento = 0,
    this.parcelasSinTratamiento = 0,
    required this.areaPorParcelaM2,
    required this.freshWeightM2g,
    required this.freshWeightKg,
    required this.dryWeightPct,
    required this.digestibleLeafPct,
    required this.biomasaDisponible,
    required this.idmsKgMsDia,
    required this.cantidadVicunas,
  });

  factory LugarBiomasa.fromJson(Map<String, dynamic> map) => LugarBiomasa(
    lugar: (map['lugar'] as String).toLowerCase(),
    parcelas: (map['parcelas'] as num).toInt(),
    parcelasEnTratamiento:
        (map['parcelas_en_tratamiento'] as num?)?.toInt() ?? 0,
    parcelasSinTratamiento:
        (map['parcelas_sin_tratamiento'] as num?)?.toInt() ?? 0,
    areaPorParcelaM2: (map['area_por_parcela_m2'] as num).toInt(),
    freshWeightM2g: (map['fresh_weight_m2_g'] as num).toDouble(),
    freshWeightKg: (map['fresh_weight_kg'] as num).toDouble(),
    dryWeightPct: (map['dry_weight_pct'] as num).toDouble(),
    digestibleLeafPct: (map['digestible_leaf_pct'] as num).toDouble(),
    biomasaDisponible: (map['biomasa_disponible'] as num).toDouble(),
    idmsKgMsDia: (map['idms_kg_ms_dia'] as num).toDouble(),
    cantidadVicunas: (map['cantidad_vicunas'] as num).toInt(),
  );

  Map<String, dynamic> toJson() => {
    'lugar': lugar,
    'parcelas': parcelas,
    'parcelas_en_tratamiento': parcelasEnTratamiento,
    'parcelas_sin_tratamiento': parcelasSinTratamiento,
    'area_por_parcela_m2': areaPorParcelaM2,
    'fresh_weight_m2_g': freshWeightM2g,
    'fresh_weight_kg': freshWeightKg,
    'dry_weight_pct': dryWeightPct,
    'digestible_leaf_pct': digestibleLeafPct,
    'biomasa_disponible': biomasaDisponible,
    'idms_kg_ms_dia': idmsKgMsDia,
    'cantidad_vicunas': cantidadVicunas,
  };
}

class BiomasaDataset {
  final List<LugarBiomasa> lugares;
  const BiomasaDataset({required this.lugares});

  factory BiomasaDataset.fromRawJson(String raw) {
    final map = json.decode(raw) as Map<String, dynamic>;
    final list = (map['lugares'] as List).cast<Map<String, dynamic>>();
    return BiomasaDataset(lugares: list.map(LugarBiomasa.fromJson).toList());
  }

  Map<String, LugarBiomasa> asByLugar() => {
    for (final l in lugares) l.lugar.toLowerCase(): l,
  };
}
