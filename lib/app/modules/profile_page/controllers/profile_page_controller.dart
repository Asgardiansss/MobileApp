import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  final _storage = FlutterSecureStorage();
  final username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsername();
  }

  void loadUsername() async {
    final storedUsername = await _storage.read(key: 'username');
    username.value = storedUsername ?? 'Guest';
  }
}

