import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // 1. إنشاء instance من الـ Secure Storage
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // مفتاح التوكن عشان نستخدمه في كل مكان ونمنع الأخطاء الإملائية
  static const String _tokenKey = 'auth_token';

  /// حفظ التوكن بأمان
  static Future<void> saveToken(String token) async {
    await _storage.write(
      key: _tokenKey,
      value: token,
      // أوبشنز إضافية للأندرويد عشان التشفير يبقى أقوى
      aOptions: const AndroidOptions(encryptedSharedPreferences: false),
    );
  }

  /// استرجاع التوكن
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// حذف التوكن (عند تسجيل الخروج)
  static Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// دالة عامة لحفظ أي بيانات تانية (اختياري)
  static Future<void> saveData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// دالة عامة لاسترجاع أي بيانات تانية (اختياري)
  static Future<String?> getData({required String key}) async {
    return await _storage.read(key: key);
  }
}
