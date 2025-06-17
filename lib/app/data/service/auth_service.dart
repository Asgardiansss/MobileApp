import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../model/auth_response_model.dart';
import '../model/user_model.dart';
import 'session_service.dart';

class AuthService {
  final String baseUrl = "https://backendcapstone.vercel.app/api";
  final _session = SessionService();

  /// ✅ LOGIN
  Future<AuthResponse> login(String email, String password) async {
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
      return auth;
    } else {
      throw Exception(body['message'] ?? 'Login failed');
    }
  }

  /// ✅ REGISTER
  Future<String> register({
    required String username,
    required String email,
    required String password,
  }) async {
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
      return data['message'] ?? 'Registration successful';
    } else {
      throw Exception(data['message'] ?? 'Register failed');
    }
  }

  /// ✅ UPDATE PROFILE (dengan atau tanpa gambar)
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

    final request = http.MultipartRequest("PATCH", url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['username'] = username
      ..fields['email'] = email;

    if (password != null && password.isNotEmpty) {
      request.fields['password'] = password;
    }

    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      if (await file.exists()) {
        request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final updatedUser = UserModel.fromJson(body['user']);
      await _session.saveUser(updatedUser.toJson());
      return body; // Kembalikan semua response (message + user)
    } else {
      print("Update failed body: ${response.body}");
      throw Exception(body['message'] ?? 'Update failed');
    }
  }


  /// ✅ Ambil User Aktif
  Future<UserModel?> getCurrentUser() async {
    final json = await _session.getUser();
    if (json != null) {
      return UserModel.fromJson(json);
    }
    return null;
  }

  /// ✅ Ambil Token
  Future<String?> getToken() async {
    return await _session.getToken();
  }

  /// ✅ Logout
  Future<void> logout() async {
    await _session.clearSession();
  }
}
