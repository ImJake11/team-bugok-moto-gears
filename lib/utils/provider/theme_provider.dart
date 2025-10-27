import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';

import '../constants/theme_colors.dart';

class MyThemeProvider extends ChangeNotifier {
  MyThemeProvider() {
    _getCurrentTheme();
  }

  final CacheRepository cacheRepository = CacheRepository();

  final List<ColorProp> _colorAccents = colorAccents;

  int _selectedIndex = 0;
  bool _isWindowMaximized =false;

  Color _primaryColor = Color(0xFFE64A19);
  Color _secondaryColor = Color(0xFFF68B1F);
  Color _teriaryColor = Color(0xFFFFC041);
  Color _surface = Color(0xFF121212);
  Color _surfaceDim = Color(0xFF121212);
  Color _borderColor = Colors.grey.shade900;
  final List<BoxShadow> _shadow = [
    BoxShadow(
      blurRadius: 2,
      spreadRadius: 2,
      color: Colors.grey.shade900,
      offset: Offset(-2, -2),
    ),
    BoxShadow(
      blurRadius: 2,
      spreadRadius: 2,
      color: Colors.black,
      offset: Offset(2, 2),
    ),
  ];

  Color get primary => _primaryColor;

  Color get secondary => _secondaryColor;

  Color get tertiary => _teriaryColor;

  Color get surface => _surface;

  Color get surfaceDim => _surfaceDim;

  Color get borderColor => _borderColor;

  int get selectedIndex => _selectedIndex;

  List<BoxShadow> get shadow => _shadow;

  bool get isWindowMaximized => _isWindowMaximized;

  void updateThemeColor(int i) => _updateThemeColor(i);

  // ================== Functions ========================//
  Future<void> _getCurrentTheme() async {
    try {
      final currentTheme = await cacheRepository.getTheme();

      _updateThemeColor(currentTheme);
    } catch (e, st) {
      print("Failed to get current theme ${e}");
      print(st);
    }
  }

  void _updateThemeColor(int i) async {
    _selectedIndex = i;
    _primaryColor = _colorAccents[i].colors[0];
    _secondaryColor = _colorAccents[i].colors[1];
    _teriaryColor = _colorAccents[i].colors[2];
    await cacheRepository.setTheme(i);
    notifyListeners();
  }

  void changeWindowValue(bool isMaximized){
    _isWindowMaximized = isMaximized;
    notifyListeners();
  }
}
