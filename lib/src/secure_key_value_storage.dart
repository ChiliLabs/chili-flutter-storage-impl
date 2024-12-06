import 'package:chili_flutter_storage/chili_flutter_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef ErrorCallback = void Function(Object ex, StackTrace st);

class SecureKeyValueStorage implements SecureStorage {
  final FlutterSecureStorage _storage;
  final bool iOSTransferToCloud;
  final ErrorCallback onError;

  final _iOSDisableCloudStoringOptions = const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  const SecureKeyValueStorage(
    this._storage, {
    required this.onError,
    this.iOSTransferToCloud = true,
  });

  /// Get
  IOSOptions? get _iosOptions =>
      iOSTransferToCloud ? null : _iOSDisableCloudStoringOptions;

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
  Future<String?> getString(String key) => _read(key);

  @override
  Future<double?> getDouble(String key) async {
    final val = await _read(key);
    if (val == null) return null;

    return double.tryParse(val);
  }

  @override
  Future<Set<String>> getKeys() async {
    return (await _readAll()).keys.toSet();
  }

  /// Set
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
  Future<void> setDouble(String key, double value) async {
    await _write(key: key, value: value.toString());
  }

  /// Utility
  @override
  Future<void> remove(String key) async {
    try {
      await _storage.delete(
        key: key,
        iOptions: _iosOptions,
      );
    } catch (ex, st) {
      onError(ex, st);
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll(
        iOptions: _iosOptions,
      );
    } catch (ex, st) {
      onError(ex, st);
    }
  }

  @override
  Future<Map<String, String>> readAll() async {
    final data = await _storage.readAll(
      iOptions: _iosOptions,
    );
    final sortedData = Map.fromEntries(
      data.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)),
    );
    return sortedData;
  }

  Future<String?> _read(String key) async {
    try {
      return await _storage.read(
        key: key,
        iOptions: _iosOptions,
      );
    } catch (ex, st) {
      onError(ex, st);

      return null;
    }
  }

  Future<Map<String, String>> _readAll() async {
    try {
      return await _storage.readAll(
        iOptions: _iosOptions,
      );
    } catch (ex, st) {
      onError(ex, st);

      return {};
    }
  }

  Future<void> _write({required String key, required String value}) async {
    try {
      await _storage.write(
        key: key,
        value: value,
        iOptions: _iosOptions,
      );
    } catch (ex, st) {
      onError(ex, st);
    }
  }
}
