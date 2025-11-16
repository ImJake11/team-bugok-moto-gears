import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';

class AuthProvider extends ChangeNotifier {
  final CacheRepository cacheRepository = CacheRepository();
  final LoadingProvider loadingProvider = LoadingProvider();
  Timer? _countdown;

  int? _password;
  bool _hasError = false;
  bool _isLoggedIn = false;
  bool _isPinRemember = false;
  bool _isLoading = false;
  bool _hasMessage = false;
  String _message = "";
  int _attempt = 0;
  int _warning = 0;
  int _currentDur = 0;
  final int _countdownDur = 60;

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

  int get currentDur => _currentDur;

  // ================== Functions ================== //

  Future<void> _checkUserSession() async {
    try {
      final result = await cacheRepository.checkUserSession();
      final password = await cacheRepository.getPassword();

      final isLoggedIn = result;

      if (isLoggedIn) {
        _password = password;

        _isLoggedIn = true;
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
        _warning = 0;
        _attempt = 0;
      } else {
        _attempt += 1;
        _hasError = true;

        if (_attempt >= 3) {
          // increase warning
          _warning += 1;
          _message = "Too many attempts try again later";
          _startTimer();
        } else {
          _message = "Wrong PIN";
        }
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

  void _startTimer() {
    _currentDur = _countdownDur * _warning;

    _countdown = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (_currentDur <= 0) {
          cancelTimer();
          _attempt = 0;
          notifyListeners();
          return;
        }

        _currentDur -= 1;
        notifyListeners();
      },
    );
  }

  void cancelTimer() {
    _countdown?.cancel();
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
