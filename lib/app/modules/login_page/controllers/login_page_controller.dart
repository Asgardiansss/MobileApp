import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../data/service/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final _authService = AuthService();
  final _storage = FlutterSecureStorage();

  // Login dengan email/password backend
  void login() async {
    isLoading.value = true;
    try {
      final response = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      print('Login response accessToken: ${response.accessToken}');
      print('Login response username: ${response.user.username}');

      await _storage.write(key: 'token', value: response.accessToken ?? '');
      await _storage.write(key: 'username', value: response.user.username ?? '');

      Get.snackbar("Success", "Welcome ${response.user.username}");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Get.snackbar("Login Dibatalkan", "Pengguna membatalkan login Google.");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Get.snackbar("Sukses", "Login Google berhasil");
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat login: $e");
    }
  }
}
