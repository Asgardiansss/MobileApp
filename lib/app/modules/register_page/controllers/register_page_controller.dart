import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../data/service/auth_service.dart';
import '../../../routes/app_pages.dart';

class RegisterPageController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final _authService = AuthService();
  final _storage = FlutterSecureStorage();

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

      Get.snackbar("Sukses", message);
      Get.offAllNamed(Routes.LOGIN_PAGE);
    } catch (e) {
      Get.snackbar("Registrasi Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
