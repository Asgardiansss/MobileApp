class UserModel {
  final String id;
  final String username;
  final String email;
  final String role;
  final String image;
  final String createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.image,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'role': role,
    'image': image,
    'created_at': createdAt,
  };
}
