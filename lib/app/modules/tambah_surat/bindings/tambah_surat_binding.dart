import 'package:get/get.dart';

import '../controllers/tambah_surat_controller.dart';

class TambahSuratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahSuratController>(
      () => TambahSuratController(),
    );
  }
}
