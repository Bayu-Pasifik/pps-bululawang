import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';
import 'package:pps_bululawang/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/surat_keluar_controller.dart';

class SuratKeluarView extends GetView<SuratKeluarController> {
  const SuratKeluarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String token = Get.arguments;
    return Scaffold(
        backgroundColor: const Color(0XFF2E2E2E),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0XFF2E2E2E),
          title: const Text('Surat Keluar'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.delete<SuratKeluarController>();
                  Get.toNamed(Routes.TAMBAH_SURAT, arguments: token);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: SmartRefresher(
            controller: controller.refreschcontroller,
            enablePullDown: true,
            onRefresh: () {
              controller.refreshData(token);
            },
            child: Obx(() => ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                padding: const EdgeInsets.all(14),
                itemCount: controller.suratList.length,
                itemBuilder: (context, index) {
                  SuratMasuk suratMasuk = controller.suratList[index];
                  return Material(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 83, 82, 82),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ExpandablePanel(
                            header: Text("${suratMasuk.noSurat}",
                                style: GoogleFonts.prompt(color: Colors.white)),
                            collapsed: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(suratMasuk.judul!,
                                    style: GoogleFonts.prompt(
                                        color: Colors.white)),
                                Text(suratMasuk.tanggalSurat!,
                                    style: GoogleFonts.prompt(
                                        color: Colors.white)),
                              ],
                            ),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(suratMasuk.judul!,
                                    style: GoogleFonts.prompt(
                                        color: Colors.white)),
                                Text(suratMasuk.tanggalSurat!,
                                    style: GoogleFonts.prompt(
                                        color: Colors.white)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // print(suratMasuk.file);
                                          controller.downloadAndView(
                                              suratMasuk.file!);
                                        },
                                        icon: const Icon(Icons.remove_red_eye)),
                                    IconButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.DETAIL_SURAT,
                                              arguments: suratMasuk);
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: "Hapus Data ?",
                                            middleText: "Yakin Hapus Data ?",
                                            confirm: ElevatedButton(
                                                onPressed: () {
                                                  print(
                                                      "id dari surat ${suratMasuk.id}");
                                                  controller.hapusSurat(token,
                                                      suratMasuk.id.toString());
                                                },
                                                child: Text(
                                                  "Ya",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                )),
                                            cancel: ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.red)),
                                                child: Text(
                                                  "Tidak",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                )),
                                          );
                                        },
                                        icon: const Icon(Icons.delete_forever)),
                                  ],
                                ),
                              ],
                            )),
                      ));
                }))));
  }
}
