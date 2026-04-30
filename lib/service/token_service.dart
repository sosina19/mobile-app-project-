import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  static Future<void> saveRole(String role) async {
    await _storage.write(key: "role", value: role);
  }

  static Future<String?> getRole() async {
    return await _storage.read(key: "role");
  }

  static Future<void> saveUserId(String id) async {
    await _storage.write(key: "userId", value: id);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: "userId");
  }

  static Future<void> saveName(String name) async {
    await _storage.write(key: "name", value: name);
  }

  static Future<String?> getName() async {
    return await _storage.read(key: "name");
  }

  static Future<void> saveEmail(String email) async {
    await _storage.write(key: "email", value: email);
  }

  static Future<String?> getEmail() async {
    return await _storage.read(key: "email");
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}