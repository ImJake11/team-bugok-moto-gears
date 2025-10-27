
import 'package:flutter/widgets.dart';

class  SettingsProvider extends ChangeNotifier {

  bool _isOnAsyncOperation = false;
  
  bool get isOnAsyncOperation => _isOnAsyncOperation;

  void toggleViewContentButton(){
        _isOnAsyncOperation = !_isOnAsyncOperation ;
        notifyListeners();
  }
}