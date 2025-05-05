import 'package:get/get.dart';

import '../controllers/anxiety_page_controller.dart';

class AnxietyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnxietyPageController>(
      () => AnxietyPageController(),
    );
  }
}
