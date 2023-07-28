import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';
import 'package:pps_bululawang/app/routes/app_pages.dart';

import '../controllers/surat_keluar_controller.dart';

class SuratKeluarView extends GetView<SuratKeluarController> {
  SuratKeluarView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Get.toNamed(Routes.TAMBAH_SURAT, arguments: token);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: SafeArea(
          child: FutureBuilder<List<SuratMasuk>>(
            future: controller.allSurat(token),
            builder: (context, snapshot) {
              // if (snapshot.hasError) {
              //   return Center(
              //     child: Text("Error : ${snapshot.error}"),
              //   );
              // }
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 10),
                  );
                }
              }
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                padding: const EdgeInsets.all(14),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  SuratMasuk suratMasuk = snapshot.data![index];
                  // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                  // String tanggal = dateFormat
                  //     .format(suratMasuk.tanggalSurat ?? DateTime.now());
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
                                          // controller.hapusSurat(
                                          //     );

                                          Get.snackbar(
                                            "success",
                                            duration:
                                                const Duration(seconds: 3),
                                            "berhasil menghapus surat keluar",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.lightBlue,
                                            icon: const Icon(Icons.add_alert),
                                          );
                                        },
                                        icon: const Icon(Icons.delete_forever)),
                                  ],
                                ),
                              ],
                            )),
                      ));
                },
              );
            },
          ),
        ));
  }
}
