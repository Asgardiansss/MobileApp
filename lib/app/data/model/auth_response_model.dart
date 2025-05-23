import 'user_model.dart';

class AuthResponse {
  final String accessToken;
  final UserModel user;
  final String message;

  AuthResponse({
    required this.accessToken,
    required this.user,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      user: UserModel.fromJson(json['data']),
      message: json['message'],
    );
  }
}
