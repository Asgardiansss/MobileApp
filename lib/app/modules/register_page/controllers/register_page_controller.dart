import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/service/auth_service.dart';
import '../../../routes/app_pages.dart';

class RegisterPageController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final _authService = AuthService();

  void register() async {
    if (usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi");
      return;
    }

    isLoading.value = true;

    try {
      final message = await _authService.register(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.snackbar(
        "Registrasi Berhasil",
        "$message\nSilakan cek email dan klik link verifikasi sebelum login.",
      );

      // Setelah register, langsung ke halaman login
      Get.offAllNamed(Routes.LOGIN_PAGE);
    } catch (e) {
      Get.snackbar("Registrasi Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
