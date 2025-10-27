import 'dart:math';

class CalculoService {

  // La configuración se pasa como un mapa de la zona activa
  Map<String, dynamic> activeConfig;

  CalculoService(this.activeConfig);

  // --- Lógica Central de Fórmulas ---

  double calcularBiomasaKg(int cantidadParcelas) {
    final areaParcela = (activeConfig['area_por_parcela_m2'] as num).toDouble();
    final pesoFrescoKg = (activeConfig['peso_fresco_m2_kg'] as num).toDouble();
    final porcSeco = (activeConfig['porcentaje_peso_seco'] as num).toDouble();
    final porcDig = (activeConfig['porcentaje_alimento_digerible'] as num).toDouble();

    if (cantidadParcelas <= 0) return 0.0;

    // pf_total_kg = area_por_parcela_m2 * peso_fresco_m2_kg * cantidad_parcelas
    final pfTotalKg = areaParcela * pesoFrescoKg * cantidadParcelas;

    // biomasa_disponible_kg = pf_total_kg * porcentaje_peso_seco * porcentaje_alimento_digerible
    final biomasaTotalKg = pfTotalKg * porcSeco * porcDig;
    
    return biomasaTotalKg;
  }

  int calcularVicunasAlimentadas(double biomasaKg) {
    final reqVicunaKgDia = (activeConfig['requerimiento_diario_vicuna_kg'] as num).toDouble();
    final diasPeriodo = (activeConfig['dias_periodo'] as num).toInt();
    final maxConsumoPorcentaje = (activeConfig['max_consumo_porcentaje'] as num).toDouble();

    // 1. Aplicar el límite de consumo (30%)
    final biomasaParaVicunas = biomasaKg * maxConsumoPorcentaje;

    // 2. Calcular el requerimiento total del periodo
    final requerimientoPeriodo = reqVicunaKgDia * diasPeriodo;
    
    if (requerimientoPeriodo <= 0) return 0;
    
    // vicunas_alimentadas = floor( biomasa_para_vicunas / requerimiento_periodo )
    final vicunas = (biomasaParaVicunas / requerimientoPeriodo);
    
    return vicunas.floor(); // Aseguramos que sea entero truncando hacia abajo
  }

  // Función combinada para usar en BiomasaScreen
  Map<String, dynamic> calcularKpis(int cantidadParcelas) {
    final biomasa = calcularBiomasaKg(cantidadParcelas);
    final vicunas = calcularVicunasAlimentadas(biomasa);
    
    return {
      'biomasa_disponible_kg': biomasa,
      'vicunas_alimentadas': vicunas,
    };
  }
}
