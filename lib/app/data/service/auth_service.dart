import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/auth_response_model.dart';

class AuthService {
  final String baseUrl = "https://backendcapstone.vercel.app/api/auth";

  Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(body);
    } else {
      throw Exception(body['message'] ?? 'Login failed');
    }
  }

  Future<String> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
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
}
