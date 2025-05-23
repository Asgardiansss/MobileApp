import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../data/service/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final _authService = AuthService();
  final _storage = FlutterSecureStorage();

  void login() async {
    isLoading.value = true;
    try {
      final response = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      await _storage.write(key: 'token', value: response.accessToken);
      await _storage.write(key: 'username', value: response.user.username);

      Get.snackbar("Success", "Welcome ${response.user.username}");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
