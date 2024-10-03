
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
  // FlutterSecureStorage instance
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Private constructor to prevent instance creation
  StorageUtils._privateConstructor();

  // Method to store a token (Static)
  static Future<void> storeValue(
      {required String key, required String value}) async {
    if (!kIsWeb) {
      return await _storage.write(key: key, value: value);
    } else {
      // html.window.localStorage[key] = value;
    }
  }

  // Method to retrieve a token (Static)
  static Future<String?> getValue({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> remove({required String key}) async {
    if (!kIsWeb) {
      return await _storage.delete(key: key);
    } else {
      // html.window.localStorage.remove(key);
    }
  }
}
