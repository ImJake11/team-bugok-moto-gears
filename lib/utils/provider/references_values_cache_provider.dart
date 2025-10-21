import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/database/repositories/store_setup_repository.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';

class ReferencesValuesProviderCache extends ChangeNotifier {
  late List<(int, String)> _sizes = [];
  late List<(int, String)> _brands = [];
  late List<(int, String)> _colors = [];
  late List<(int, String)> _categories = [];
  late List<(int, String)> _models = [];

  final StoreSetupRepository _storeSetupRepository = StoreSetupRepository();

  ReferencesValuesProviderCache() {
    fetchReferenceValues();
  }

  List<(int, String)> get sizes => _sizes;

  List<(int, String)> get brands => _brands;

  List<(int, String)> get colors => _colors;

  List<(int, String)> get categories => _categories;

  List<(int, String)> get models => _models;

  Future<void> fetchReferenceValues() async => _fetchReferencesValues();

  // ====================== Private Functions ==================//
  Future<void> _fetchReferencesValues() async {
    try {
      _brands = await _storeSetupRepository.getReferencesValues(
        ReferenceType.brands,
      );

      _sizes = await _storeSetupRepository.getReferencesValues(
        ReferenceType.sizes,
      );

      _colors = await _storeSetupRepository.getReferencesValues(
        ReferenceType.colors,
      );

      _categories = await _storeSetupRepository.getReferencesValues(
        ReferenceType.categories,
      );

      _models = await _storeSetupRepository.getReferencesValues(
        ReferenceType.models,
      );

      print("Reference Values Fetched");
      notifyListeners();
    } catch (e, st) {
      print("Failed to fetch reference value ${e}");
      print(st);
    }
  }
}
