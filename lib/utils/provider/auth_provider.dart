import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';

class AuthProvider extends ChangeNotifier {
  final CacheRepository cacheRepository = CacheRepository();
  final LoadingProvider loadingProvider = LoadingProvider();

  final List<int> _password = [];
  bool _hasError = false;
  bool _isLoggedIn = false;
  bool _isPinRemember = false;
  bool _isLoading = false;

  List<int> get password => _password;
  bool get hasError => _hasError;
  bool get isPinRemember => _isPinRemember;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  void addInput(int input) => _addInput(input);
  void deleteLast() => _deleteLast();
  void toggleCheckBox() => _toggleCheckBox();
  Future<void> checkUserSession() async => _checkUserSession();

  // ================== Functions ================== //

  Future<void> _checkUserSession() async {
    try {
      final result = await cacheRepository.checkUserSession();
      final password = await cacheRepository.getPassword();

      final passwordDigits = password.toString().split("");

      final (isLoggedIn, isRememberedPin) = result;

      if (isLoggedIn == 1) {
        for (final p in passwordDigits) {
          _password.add(int.parse(p));
          notifyListeners();
        }
        _isLoggedIn = true;
      }

      notifyListeners();
    } catch (e, st) {
      print("Failed to check user session ${e}");
      print(st);
    }
  }

  Future<void> _checkPassword() async {
    _isLoading = true;

    final int password = await cacheRepository.getPassword();

    final joinedPasswordInput = _password.join();

    if (password == int.parse(joinedPasswordInput)) {
      _isLoggedIn = true;
      await cacheRepository.loginUser(_isPinRemember);
    } else {
      _hasError = true;
    }

    await Future.delayed(Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }

  void _addInput(int number) {
    if (_password.length >= 6) return;
    _password.add(number);

    if (_password.length == 6) {
      _checkPassword();
    }

    notifyListeners();
  }

  void _deleteLast() {
    if (_hasError) _hasError = false;
    if (_isLoading) _isLoading = false;
    if (_password.isEmpty) return;

    _password.removeLast();
    notifyListeners();
  }

  void _toggleCheckBox() {
    _isPinRemember = !_isPinRemember;
    notifyListeners();
  }
}
