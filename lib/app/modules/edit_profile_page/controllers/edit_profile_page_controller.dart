import 'package:flutter/cupertino.dart';
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
  final imageUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();

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
        imageUrl.value = user.image ?? ''; // set initial image URL
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data pengguna');
    }
  }

  // Method untuk memilih gambar dari gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageUrl.value = pickedFile.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih gambar dari galeri');
    }
  }

  // Method untuk mengambil gambar dari kamera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        imageUrl.value = pickedFile.path;
      }
    } catch (e) {
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
      print('imageUrl saat update: ${imageUrl.value}');

      final isImageUrlAValidUrl = Uri.tryParse(imageUrl.value)?.hasScheme == true &&
          (imageUrl.value.startsWith('http://') || imageUrl.value.startsWith('https://'));

      final imagePathToUpload = isImageUrlAValidUrl ? null : imageUrl.value;

      final response = await _authService.updateProfile(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.isEmpty ? null : passwordController.text,
        imagePath: imagePathToUpload,
      );

      final updatedUser = response['user'];

      if (updatedUser != null) {
        usernameController.text = updatedUser['username'] ?? usernameController.text;
        emailController.text = updatedUser['email'] ?? emailController.text;
        imageUrl.value = updatedUser['image'] ?? imageUrl.value;
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
      print('Error saat update profile: $e');
      print(st);
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
