import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';

class CacheRepository {
  final db = appDatabase;

  Future<int> getPassword() async => _getPassword();

  Future<void> loginUser(bool isRememberedPin) async =>
      _logInUser(isRememberedPin);

  Future<(int, int)> checkUserSession() async => _checkUserSession();

  Future<int> getTheme() async => _getTheme();

  Future<void> setTheme(int index) async => _setTheme(index);

  Future<void> saveNewPin(int newPin) async => _saveNewPin(newPin);

  Future<void> logOut() async => _logOut();

  Future<void> setLastSync() async => _setLastSync();

  Future<DateTime?> getLatestSync() async => _getLatestSync();

  // ============================================= //
Future<DateTime?> _getLatestSync() async {
  try {

    final result = await db.select(db.caches).getSingle();

    return result.lastSync;
  } catch(e, st){
    print("Failed to get latest sync record");
    print(st);
    rethrow;
  }
}
  Future<void> _setLastSync() async {
    try {
      await db
          .update(db.caches)
          .write(
            CachesCompanion(
              lastSync: Value(DateTime.now()),
            ),
          );
    } catch (e, st) {
      print('Failed to set sync ${e}');
      print(st);
      rethrow;
    }
  }

  Future<int> _getTheme() async {
    try {
      final result = await db.select(db.caches).getSingle();

      return result.theme;
    } catch (e, st) {
      print("Failed to get current theme ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _setTheme(int index) async {
    try {
      await db
          .update(db.caches)
          .write(
            CachesCompanion(
              theme: Value(index),
            ),
          );
    } catch (e, st) {
      print("Failed to set theme ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _saveNewPin(int newPin) async {
    try {
      await db
          .update(db.caches)
          .write(
            CachesCompanion(
              password: Value(newPin),
            ),
          );
    } catch (e, st) {
      print("Failed to save new pin ${e}");
      print(st);
      rethrow;
    }
  }

  Future<(int, int)> _checkUserSession() async {
    try {
      Cache cache = await db.select(db.caches).getSingle();

      return (cache.isLoggedIn, cache.isRememberedPin);
    } catch (e, st) {
      print("Failed to check user session ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _logInUser(bool isRememberedPin) async {
    try {
      await db
          .update(db.caches)
          .write(
            CachesCompanion(
              isLoggedIn: Value(1),
              isRememberedPin: Value(isRememberedPin ? 1 : 0),
            ),
          );
    } catch (e, st) {
      print("Failed to logged in user ${e}");
      print(st);
      rethrow;
    }
  }

  Future<int> _getPassword() async {
    try {
      final query = db.select(db.caches).map((row) => row.password).getSingle();

      final password = await query;

      return password;
    } catch (e, st) {
      print("Failed to get password ${e}");
      print(st);
      rethrow;
    }
  }

  Future<void> _logOut() async {
    try {
      await db
          .update(db.caches)
          .write(
            CachesCompanion(
              isLoggedIn: Value(0),
            ),
          );
    } catch (e, st) {
      print("Failed to log out ${e}");
      print(st);
      rethrow;
    }
  }
}
