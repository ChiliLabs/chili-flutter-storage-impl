import 'package:chili_flutter_storage/chili_flutter_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeyValueStorage implements SharedPreferencesStorage {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesKeyValueStorage(this._sharedPreferences);

  @override
  Future<Set<String>> getKeys() async {
    return _sharedPreferences.getKeys();
  }

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<void> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _sharedPreferences.getInt(key);
  }

  @override
  Future<void> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  @override
  Future<void> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  @override
  Future<void> clearAll() {
    return _sharedPreferences.clear();
  }

  @override
  Future<void> setDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  @override
  Future<Map<String, String>> readAll() async {
    final allKeys = await getKeys();
    var data = <String, String>{};

    for (final key in allKeys) {
      final value = _sharedPreferences.get(key);
      data[key] = value.toString();
    }

    return data;
  }
}
