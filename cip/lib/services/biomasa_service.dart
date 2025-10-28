import 'package:flutter/services.dart' show rootBundle;
import 'package:cip/models/biomasa_dataset.dart';

class BiomasaService {
  BiomasaService._();

  static Future<BiomasaDataset> loadDataset() async {
    final raw = await rootBundle.loadString('assets/data/biomasa.json');
    return BiomasaDataset.fromRawJson(raw);
  }
}
