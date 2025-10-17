import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";

  bool get isLoading => _isLoading;
  String get message => _message;

  // ============= Functions ======================== //
  void showLoading(String message) {
    _isLoading = true;
    _message = message;
    notifyListeners();
  }

  void closeLoading() {
    _message = "";
    _isLoading = false;
    notifyListeners();
  }
}
