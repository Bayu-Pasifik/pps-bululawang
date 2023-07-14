import 'package:get/get.dart';

import '../controllers/surat_masuk_controller.dart';

class SuratMasukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratMasukController>(
      () => SuratMasukController(),
    );
  }
}
