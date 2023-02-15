import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chili_flutter_storage/chili_flutter_storage.dart';

typedef ErrorCallback = void Function(Object ex, StackTrace st);

class SecureKeyValueStorage implements KeyValueStorage {
  final FlutterSecureStorage _storage;
  final ErrorCallback onError;

  const SecureKeyValueStorage(this._storage, {required this.onError});

  @override
  Future<bool?> getBool(String key) async {
    final val = await _read(key);
    if (val == null) return null;

    return val.toLowerCase() == 'true';
  }

  @override
  Future<int?> getInt(String key) async {
    final val = await _read(key);
    if (val == null) return null;

    return int.tryParse(val);
  }

  @override
  Future<Set<String>> getKeys() async {
    return (await _readAll()).keys.toSet();
  }

  @override
  Future<String?> getString(String key) => _read(key);

  @override
  Future<void> setBool(String key, bool value) async {
    await _write(key: key, value: value ? 'true' : 'false');
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _write(key: key, value: value.toString());
  }

  @override
  Future<void> setString(String key, String value) async {
    await _write(key: key, value: value);
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (ex, st) {
      onError(ex, st);
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (ex, st) {
      onError(ex, st);
    }
  }

  Future<String?> _read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (ex, st) {
      onError(ex, st);

      return null;
    }
  }

  Future<Map<String, String>> _readAll() async {
    try {
      return await _storage.readAll();
    } catch (ex, st) {
      onError(ex, st);

      return {};
    }
  }

  Future<void> _write({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (ex, st) {
      onError(ex, st);
    }
  }
}
