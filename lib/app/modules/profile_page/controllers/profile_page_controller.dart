import 'package:get/get.dart';
import '../../../data/service/auth_service.dart';
import '../../../data/service/session_service.dart';

class ProfilePageController extends GetxController {
  var username = ''.obs;
  var imageUrl = ''.obs;
  var email = ''.obs;
  var isLoading = true.obs;

  final AuthService authService = AuthService();  // tambahkan ini

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    final user = await SessionService().getUser();
    username.value = user?['username'] ?? 'Guest';
    email.value = user?['email'] ?? '-';
    imageUrl.value = user?['image'] ?? '';
    isLoading.value = false;
  }
}

