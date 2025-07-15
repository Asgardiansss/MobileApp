import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class SessionService {
  static const String _tokenKey = 'access_token';
  static const String _userKey = 'user_data';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return jsonDecode(userJson);
    }
    return null;
  }

  /// Ambil nama device
  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return '${androidInfo.brand} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return '${iosInfo.name} ${iosInfo.model}';
      } else {
        return 'Unknown Device';
      }
    } catch (e) {
      return 'Unknown Device';
    }
  }

  /// Ambil IP publik
  Future<String> getPublicIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org'));
      if (response.statusCode == 200) {
        return response.body;
      }
      return 'Unknown IP';
    } catch (e) {
      return 'Unknown IP';
    }
  }

  /// Simpan login history (format baru)
  Future<void> addLoginHistory({
    required String device,
    required String ipAddress,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('login_history') ?? [];

    final newItem = {
      'time_login': DateTime.now().toIso8601String(),
      'device': device,
      'ip_address': ipAddress,
    };

    rawList.insert(0, jsonEncode(newItem)); // paling baru di atas
    await prefs.setStringList('login_history', rawList);
  }

  /// Ambil login history (format baru)
  Future<List<Map<String, dynamic>>> getLoginHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('login_history') ?? [];
    print('DEBUG: login history rawList = $rawList');

    List<Map<String, dynamic>> result = [];
    for (var item in rawList) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic> &&
            decoded.containsKey('time_login') &&
            decoded.containsKey('device') &&
            decoded.containsKey('ip_address')) {
          result.add(decoded);
        } else {
          print('WARNING: Ignored invalid login history item (missing keys): $decoded');
        }
      } catch (e) {
        print('ERROR decoding login history item: $item, error: $e');
      }
    }

    return result;
  }




  /// Hapus semua login history
  Future<void> cleanLoginHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('login_history') ?? [];

    List<String> cleanList = [];

    for (var item in rawList) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic> &&
            decoded.containsKey('time_login') &&
            decoded.containsKey('device') &&
            decoded.containsKey('ip_address')) {
          cleanList.add(item);
        }
      } catch (_) {
        // skip corrupt item
      }
    }

    await prefs.setStringList('login_history', cleanList);
  }



  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
