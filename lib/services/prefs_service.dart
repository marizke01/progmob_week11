import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  // ==========================
  // INIT
  // ==========================
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==========================
  // LOGIN DATA
  // ==========================
  static Future setUsername(String value) async {
    await _prefs?.setString('username', value);
  }

  static String getUsername() {
    return _prefs?.getString('username') ?? "";
  }

  static Future setPassword(String value) async {
    await _prefs?.setString('password', value);
  }

  static String getPassword() {
    return _prefs?.getString('password') ?? "";
  }

  static Future setLoggedIn(bool value) async {
    await _prefs?.setBool('logged_in', value);
  }

  static bool getLoggedIn() {
    return _prefs?.getBool('logged_in') ?? false;
  }

  // ==========================
  // THEME MODE
  // ==========================
  static Future setDarkMode(bool value) async {
    await _prefs?.setBool("dark_mode", value);
  }

  static bool getDarkMode() {
    return _prefs?.getBool("dark_mode") ?? false;
  }

  // ==========================
  // LAST REFRESH (CACHE)
  // ==========================
  static Future setLastRefresh(String value) async {
    await _prefs?.setString("last_refresh", value);
  }

  static String getLastRefresh() {
    return _prefs?.getString("last_refresh") ?? "Never refreshed";
  }

  static Future clearCache() async {
    await _prefs?.remove("last_refresh");
  }
}
