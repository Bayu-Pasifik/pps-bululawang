import 'package:get/get.dart';

import '../controllers/detail_surat_controller.dart';

class DetailSuratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSuratController>(
      () => DetailSuratController(),
    );
  }
}
