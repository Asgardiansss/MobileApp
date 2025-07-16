import 'package:get/get.dart';

import '../controllers/visualisasi_deteksi_controller.dart';

class VisualisasiDeteksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisualisasiDeteksiController>(
      () => VisualisasiDeteksiController(),
    );
  }
}
