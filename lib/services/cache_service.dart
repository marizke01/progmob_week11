import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String cacheKey = "cached_data";
  static const String refreshKey = "last_refresh";

  // Simpan data ke cache
  static Future<void> saveToCache(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, data);
    await prefs.setString(refreshKey, DateTime.now().toIso8601String());
  }

  // Ambil data
  static Future<String?> loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(cacheKey);
  }

  // Ambil timestamp terakhir refresh
  static Future<String?> getLastRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshKey);
  }

  // Clear semua cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
    await prefs.remove(refreshKey);
  }
}
