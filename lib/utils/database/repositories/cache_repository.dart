import 'package:supabase_flutter/supabase_flutter.dart';

class CacheRepository {
  late final SupabaseClient supabase;

  CacheRepository() : supabase = Supabase.instance.client;

  Future<int> getPassword() async => _getPassword();

  Future<void> loginUser(bool isRememberedPin) async =>
      _logInUser(isRememberedPin);

  Future<bool> checkUserSession() async => _checkUserSession();

  Future<int> getTheme() async => _getTheme();

  Future<void> setTheme(int index) async => _setTheme(index);

  Future<void> saveNewPin(int newPin) async => _saveNewPin(newPin);

  Future<void> logOut() async => _logOut();

  Future<int> _getTheme() async {
    try {
      final result = await supabase.from('cache').select('theme');

      if (result.isEmpty) return 0;

      final theme = result.first['theme'];

      print('✅ Theme is set to $theme');
      return theme;
    } catch (e, st) {
      print("Failed to get current theme ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _setTheme(int index) async {
    try {
      await supabase
          .from('cache')
          .update({
            'theme': index,
          })
          .eq('id', 1);

      print('✅ Theme updated');
    } catch (e, st) {
      print("Failed to set theme ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _saveNewPin(int newPin) async {
    try {
      await supabase
          .from('cache')
          .update({
            'password': newPin,
          })
          .eq('id', 1);
      print('✅ New PIN saved');
    } catch (e, st) {
      print("Failed to save new pin ${e}");
      print(st);
      rethrow;
    }
  }

  Future<bool> _checkUserSession() async {
    try {
      final res = await supabase.from('cache').select('is_logged_in');

      if (res.isEmpty) return false;

      final isLoggedIn = res.first['is_logged_in'] == 1;

      return isLoggedIn;
    } catch (e, st) {
      print("Failed to check user session ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _logInUser(bool isRememberedPin) async {
    try {
      await supabase
          .from('cache')
          .update({
            'is_logged_in': 1,
          })
          .eq('id', 1);
      print('✅ User logged in successfully');
    } catch (e, st) {
      print("Failed to logged in user ${e}");
      print(st);
      rethrow;
    }
  }

  Future<int> _getPassword() async {
    try {
      final res = await supabase.from('cache').select('password');

      if (res.isEmpty) return 10242025;

      final password = res.first['password'];

      print('✅ Password retrieved');
      return password;
    } catch (e, st) {
      print("Failed to get password ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _logOut() async {
    try {
      await supabase
          .from('cache')
          .update({
            'is_logged_in': 0,
          })
          .eq(
            'id',
            1,
          );
      print("✅ User logged out successfully");
    } catch (e, st) {
      print("Failed to log out ${e}");
      print(st);
      rethrow;
    }
  }
}
