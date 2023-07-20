import 'package:get/get.dart';

import '../modules/detailSurat/bindings/detail_surat_binding.dart';
import '../modules/detailSurat/views/detail_surat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/surat_keluar/bindings/surat_keluar_binding.dart';
import '../modules/surat_keluar/views/surat_keluar_view.dart';
import '../modules/surat_masuk/bindings/surat_masuk_binding.dart';
import '../modules/surat_masuk/views/surat_masuk_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SURAT_MASUK,
      page: () => const SuratMasukView(),
      binding: SuratMasukBinding(),
    ),
    GetPage(
      name: _Paths.SURAT_KELUAR,
      page: () => SuratKeluarView(),
      binding: SuratKeluarBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SURAT,
      page: () =>  DetailSuratView(),
      binding: DetailSuratBinding(),
    ),
  ];
}
