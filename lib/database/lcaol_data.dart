import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static late SharedPreferences _preferences;
  static Future<SharedPreferences> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static signout() => _preferences.clear();

  static const String _themeKey = 'ThemeKey';

  static Future<void> setThemeMode(int value) async =>
      await _preferences.setInt(_themeKey, value);

  static int? themeMode() => _preferences.getInt(_themeKey);
}