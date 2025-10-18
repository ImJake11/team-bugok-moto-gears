import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  List<int> _password = [];
  bool _hasError = false;
  bool _isPinRemember = false;

  List<int> get password => _password;
  bool get hasError => _hasError;
  bool get isPinRemember => _isPinRemember;

  void addInput(int number) {
    if (_password.length >= 6) return;

    _password.add(number);

    print(_password);
    _hasError = true;
    notifyListeners();
  }

  void deleteLast() {
    if (_hasError) _hasError = false;
    if (_password.isEmpty) return;

    _password.removeLast();
    notifyListeners();
  }

  void toggleCheckBox(){
    _isPinRemember = !_isPinRemember;
    notifyListeners();
  }
}
