import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  // SharedPreferences instance
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save data to SharedPreferences
  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Get data from SharedPreferences
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Remove data from SharedPreferences
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all data from SharedPreferences
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
