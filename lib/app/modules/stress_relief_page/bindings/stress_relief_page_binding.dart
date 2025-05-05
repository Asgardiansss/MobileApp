import 'package:get/get.dart';

import '../controllers/stress_relief_page_controller.dart';

class StressReliefPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StressReliefPageController>(
      () => StressReliefPageController(),
    );
  }
}
