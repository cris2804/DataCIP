// Removed unused import

class CalculoService {
  // La configuración se pasa como un mapa de la zona activa
  Map<String, dynamic> activeConfig;

  CalculoService(this.activeConfig);

  // --- Lógica Central de Fórmulas ---

  double calcularBiomasaKg(int cantidadParcelas) {
    final areaParcela = (activeConfig['area_por_parcela_m2'] as num).toDouble();
    final pesoFrescoKg = (activeConfig['peso_fresco_m2_kg'] as num).toDouble();
    final porcSeco = (activeConfig['porcentaje_peso_seco'] as num).toDouble();
    final porcDig = (activeConfig['porcentaje_alimento_digerible'] as num)
        .toDouble();

    if (cantidadParcelas <= 0) return 0.0;

    // pf_total_kg = area_por_parcela_m2 * peso_fresco_m2_kg * cantidad_parcelas
    final pfTotalKg = areaParcela * pesoFrescoKg * cantidadParcelas;

    // biomasa_disponible_kg = pf_total_kg * porcentaje_peso_seco * porcentaje_alimento_digerible
    final biomasaTotalKg = pfTotalKg * porcSeco * porcDig;

    return biomasaTotalKg;
  }

  int calcularVicunasAlimentadas(double biomasaKg) {
    // Fórmula pedida: vicuñas = biomasa_disponible * 0.3 / (365 * IDMS)
    // donde IDMS = requerimiento diario (kg MS/día)
    const double factorUtilizacion = 0.30;
    const int diasAnio = 365;
    final idmsKgDia = (activeConfig['requerimiento_diario_vicuna_kg'] as num)
        .toDouble();

    if (idmsKgDia <= 0) return 0;

    final vicunas = (biomasaKg * factorUtilizacion) / (diasAnio * idmsKgDia);
    return vicunas.floor();
  }

  // Función combinada para usar en BiomasaScreen
  Map<String, dynamic> calcularKpis(int cantidadParcelas) {
    // Recalcular PF total para exponerlo en los resultados
    final areaParcela = (activeConfig['area_por_parcela_m2'] as num).toDouble();
    final pesoFrescoM2Kg = (activeConfig['peso_fresco_m2_kg'] as num)
        .toDouble();
    final porcSeco = (activeConfig['porcentaje_peso_seco'] as num).toDouble();
    final porcDig = (activeConfig['porcentaje_alimento_digerible'] as num)
        .toDouble();

    final pfTotalKg = areaParcela * pesoFrescoM2Kg * cantidadParcelas;
    // Fórmula de biomasa según indicación: PF kg * dry% * digestible%
    final biomasa = pfTotalKg * porcSeco * porcDig;
    final vicunas = calcularVicunasAlimentadas(biomasa);

    return {
      'fresh_weight_kg': pfTotalKg,
      'biomasa_disponible_kg': biomasa,
      'vicunas_alimentadas': vicunas,
    };
  }
}
