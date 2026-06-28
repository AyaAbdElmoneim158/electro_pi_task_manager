import 'package:electro_pi_task/core/error/cache_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._(this._prefs);
  final SharedPreferences _prefs;
  static late SharedPreferencesService instance;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    instance = SharedPreferencesService._(prefs);
  }

  dynamic getData({required String key}) {
    try {
      return _prefs.get(key);
    } catch (e) {
      handleCacheException(e);
      return null;
    }
  }

  String? getDataString({required String key}) {
    try {
      debugPrint('💾 Getting Cache: [$key]');
      return _prefs.getString(key);
    } catch (e) {
      handleCacheException(e);
      return null;
    }
  }

  /// Universal setter
  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    try {
      debugPrint('💾 Saving Cache: [$key] = $value');
      switch (value) {
        case String():
          return await _prefs.setString(key, value);
        case bool():
          return await _prefs.setBool(key, value);
        case int():
          return await _prefs.setInt(key, value);
        case double():
          return await _prefs.setDouble(key, value);
        case List<String>():
          return await _prefs.setStringList(key, value);
        default:
          throw CacheException('Unsupported data type: ${value.runtimeType}');
      }
    } catch (e) {
      handleCacheException(e);
      return false;
    }
  }

  bool containsKey({required String key}) {
    return _prefs.containsKey(key);
  }

  Future<bool> removeData({required String key}) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      handleCacheException(e);
      return false;
    }
  }

  Future<bool> clearData() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      handleCacheException(e);
      return false;
    }
  }
}
