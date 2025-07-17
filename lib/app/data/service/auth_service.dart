import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import '../model/auth_response_model.dart';
import '../model/user_model.dart';
import 'session_service.dart';

class AuthService {
  final String baseUrl = "https://backendcapstone.vercel.app/api";
  final _session = SessionService();

  Future<String> _getDeviceName() async {
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

  Future<String> _getPublicIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Unknown IP';
      }
    } catch (e) {
      return 'Unknown IP';
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    print("🔐 Attempting login for: $email");

    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final auth = AuthResponse.fromJson(body);
      await _session.saveToken(auth.accessToken);
      await _session.saveUser(auth.user.toJson());

      final device = await _getDeviceName();
      final ipAddress = await _getPublicIpAddress();

      print('🖥️ Device: $device');
      print('🌐 IP Address: $ipAddress');

      await _session.addLoginHistory(device: device, ipAddress: ipAddress);
      print('📒 Login history saved');

      return auth;
    } else {
      print("❌ Login failed: ${body['message']}");
      throw Exception(body['message'] ?? 'Login failed');
    }
  }

  Future<String> register({
    required String username,
    required String email,
    required String password,
  }) async {
    print("📨 Attempting registration for: $email");

    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      print("✅ Registration successful");
      return data['message'] ?? 'Registration successful';
    } else {
      print("❌ Registration failed: ${data['message']}");
      throw Exception(data['message'] ?? 'Register failed');
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String username,
    required String email,
    String? password,
    String? imagePath,
  }) async {
    final token = await _session.getToken();
    final user = await _session.getUser();

    if (token == null || user == null) {
      throw Exception("Unauthorized");
    }

    final userId = user['id'];
    final url = Uri.parse('$baseUrl/users/$userId');

    print("🛠️ Updating profile for userId: $userId");
    print("🔧 username: $username");
    print("📧 email: $email");
    print("🔑 password: ${password != null ? '•••' : '(not changed)'}");
    print("🖼️ imagePath: $imagePath");

    final request = http.MultipartRequest("PATCH", url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['username'] = username
      ..fields['email'] = email;

    if (password != null && password.isNotEmpty) {
      request.fields['password'] = password;
    }

    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      print("📁 Checking file: $imagePath");
      print("📂 File exists: ${await file.exists()}");

      if (await file.exists()) {
        print("🚀 Adding file to multipart request...");
        request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      } else {
        print("⚠️ File not found, image will not be uploaded.");
      }
    }

    print("📡 Sending PATCH request to: $url");

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("📬 Response status: ${response.statusCode}");
    print("📨 Response body: ${response.body}");

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final updatedUser = UserModel.fromJson(body['user']);
      await _session.saveUser(updatedUser.toJson());
      print("✅ Profile updated successfully");
      return body;
    } else {
      print("❌ Update failed: ${body['message']}");
      throw Exception(body['message'] ?? 'Update failed');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final json = await _session.getUser();
    if (json != null) {
      print("👤 Current user: ${json['username']}");
      return UserModel.fromJson(json);
    }
    return null;
  }

  Future<String?> getToken() async {
    return await _session.getToken();
  }

  Future<void> logout() async {
    print("🔓 Logging out...");
    await _session.clearSession();
    print("✅ Session cleared");
  }
}
