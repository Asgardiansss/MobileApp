import 'package:get/get.dart';
import '../../../data/service/session_service.dart';

class HomeController extends GetxController {
  var username = ''.obs;
  var imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final user = await SessionService().getUser();
    username.value = user?['username'] ?? 'Guest';
    imageUrl.value = user?['image'] ?? '';
  }
}
