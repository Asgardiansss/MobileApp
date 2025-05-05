import 'package:get/get.dart';

import '../controllers/detail_stress_relief_controller.dart';

class DetailStressReliefBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStressReliefController>(
      () => DetailStressReliefController(),
    );
  }
}
