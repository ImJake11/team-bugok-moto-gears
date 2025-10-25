import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';

class AuthProvider extends ChangeNotifier {
  final CacheRepository cacheRepository = CacheRepository();
  final LoadingProvider loadingProvider = LoadingProvider();

  int? _password;
  bool _hasError = false;
  bool _isLoggedIn = false;
  bool _isPinRemember = false;
  bool _isLoading = false;
  bool _hasMessage = false;
  String _message = "";

  bool get hasError => _hasError;

  bool get isPinRemember => _isPinRemember;

  bool get isLoggedIn => _isLoggedIn;

  bool get isLoading => _isLoading;

  bool get hasMessage => _hasMessage;

  String get message => _message;

  void addInput(int input) => _addInput(input);

  void toggleCheckBox() => _toggleCheckBox();

  void setUserAsLoggedOut() => _setUserAsLoggedOut();

  Future<void> checkUserSession() async => _checkUserSession();

  Future<void> checkPassword() async => _checkPassword();

  // ================== Functions ================== //

  Future<void> _checkUserSession() async {
    try {
      final result = await cacheRepository.checkUserSession();
      final password = await cacheRepository.getPassword();

      final (isLoggedIn, isRememberedPin) = result;

      if (isLoggedIn == 1) {
        _password = password;

        _isLoggedIn = true;
        _isPinRemember = isRememberedPin == 1;
      } else {
        _isLoggedIn = false;
        _isPinRemember = false;
      }

      // 🔔 Always notify
      notifyListeners();
    } catch (e, st) {
      print("Failed to check user session: $e");
      print(st);
      _isLoggedIn = false;
      _isPinRemember = false;
      notifyListeners(); // 🔔 Also notify even on error
    }
  }

  Future<void> _checkPassword() async {
    try {
      _isLoading = true;
      _hasError = false;
      _hasMessage = false;
      _message = '';
      notifyListeners();

      // ✅ Let Flutter rebuild UI first before continuing
      await Future.delayed(Duration(seconds: 2));

      final savedPassword = await cacheRepository.getPassword();

      if (_password == null || _password.toString().length < 6) {
        _hasError = true;
        _message = "Please enter your PIN";
        return;
      }

      if (savedPassword == _password) {
        _isLoggedIn = true;
        _message = "Logged in successfully";
        await cacheRepository.loginUser(_isPinRemember);
      } else {
        _hasError = true;
        _message = "Wrong PIN";
      }
    } catch (e, st) {
      print('❌ Failed to sign in: $e');
      print(st);
      _hasError = true;
      _message = "System error occurred";
    } finally {
      _isLoading = false;
      _hasMessage = true;
      notifyListeners();
    }
  }

  void _addInput(int input) {
    _password = input;
    notifyListeners();
  }

  void _setUserAsLoggedOut() {
    _resetToDefault();
  }

  void _resetToDefault() {
    _isLoading = false;
    _isLoggedIn = false;
    _hasError = false;
    _password = null;
  }

  void _toggleCheckBox() {
    _isPinRemember = !_isPinRemember;
    notifyListeners();
  }
}
