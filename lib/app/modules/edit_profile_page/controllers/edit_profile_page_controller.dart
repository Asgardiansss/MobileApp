import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/colors.dart';
import '../../../data/service/auth_service.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile_page/controllers/profile_page_controller.dart';

class EditProfilePageController extends GetxController {
  final _authService = AuthService();
  final _storage = FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();

  final imageUrl = ''.obs;
  final imagePath = ''.obs;

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        usernameController.text = user.username;
        emailController.text = user.email;
        imageUrl.value = user.image ?? '';
        print("📥 Loaded user data: ${user.toJson()}");
      }
    } catch (e) {
      print("❌ Gagal load user data: $e");
      Get.snackbar('Error', 'Gagal memuat data pengguna');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagePath.value = pickedFile.path;
        print("📸 Gambar dipilih dari galeri: ${pickedFile.path}");
      }
    } catch (e) {
      print("❌ Gagal pilih gambar dari galeri: $e");
      Get.snackbar('Error', 'Gagal memilih gambar dari galeri');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        imagePath.value = pickedFile.path;
        print("📷 Gambar diambil dari kamera: ${pickedFile.path}");
      }
    } catch (e) {
      print("❌ Gagal ambil gambar dari kamera: $e");
      Get.snackbar('Error', 'Gagal mengambil gambar dari kamera');
    }
  }

  Future<void> updateProfile() async {
    if (usernameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Username tidak boleh kosong');
      return;
    }
    if (emailController.text.trim().isEmpty || !emailController.text.contains('@')) {
      Get.snackbar('Error', 'Email tidak valid');
      return;
    }

    isLoading.value = true;

    try {
      print("⏳ Update profile mulai...");
      print("username: ${usernameController.text}");
      print("email: ${emailController.text}");
      print("password: ${passwordController.text}");
      print("📤 imagePath (local): ${imagePath.value}");
      print("🌐 imageUrl (current): ${imageUrl.value}");

      final imagePathToUpload = imagePath.value.isNotEmpty ? imagePath.value : null;

      final response = await _authService.updateProfile(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.isEmpty ? null : passwordController.text,
        imagePath: imagePathToUpload,
      );

      final updatedUser = response['user'];
      print('🎯 Updated image from backend: ${updatedUser['image']}');

      if (updatedUser != null) {
        usernameController.text = updatedUser['username'] ?? usernameController.text;
        emailController.text = updatedUser['email'] ?? emailController.text;
        imageUrl.value = updatedUser['image'] ?? imageUrl.value;
        imagePath.value = ''; // Clear path setelah upload
      }

      await _storage.write(key: 'username', value: usernameController.text.trim());

      final profileController = Get.find<ProfilePageController>();
      await profileController.loadUserProfile();

      final homeController = Get.find<HomeController>();
      await homeController.loadUserProfile();

      passwordController.clear();

      await showDialog(
        context: Get.context!,
        builder: (context) => Dialog(
          backgroundColor: AppColorsDark.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColorsDark.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Color(0xFF575757), offset: Offset(-2, -2), blurRadius: 1),
                BoxShadow(color: Color(0xFF000000), offset: Offset(2, 2), blurRadius: 1),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Berhasil!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColorsDark.teksPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  response['message'] ?? 'Profil berhasil diperbarui',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColorsDark.teksPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.back();
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColorsDark.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Color(0xFF575757), offset: Offset(-2, -2), blurRadius: 1),
                        BoxShadow(color: Color(0xFF000000), offset: Offset(2, 2), blurRadius: 1),
                      ],
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: AppColorsDark.teksPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e, st) {
      print('❌ Error saat update profile: $e');
      print('🪵 Stacktrace: $st');
      Get.snackbar(
        "Gagal",
        "Terjadi kesalahan saat menyimpan data.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
