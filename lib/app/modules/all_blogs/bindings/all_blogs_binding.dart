import 'package:get/get.dart';

import '../controllers/all_blogs_controller.dart';

class AllBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllBlogsController>(
      () => AllBlogsController(),
    );
  }
}
