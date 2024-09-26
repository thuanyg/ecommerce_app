import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
  // FlutterSecureStorage instance
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Private constructor to prevent instance creation
  StorageUtils._privateConstructor();

  // Method to store a token (Static)
  static Future<void> storeToken({required String key, required String token}) async {
    await _storage.write(key: key, value: token);
  }

  // Method to retrieve a token (Static)
  static Future<String?> getToken({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> remove({required String key}) async {
    return await _storage.delete(key: key);
  }
}
