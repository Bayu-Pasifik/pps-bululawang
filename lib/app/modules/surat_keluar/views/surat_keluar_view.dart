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
                  Get.defaultDialog(
                    title: "Form Surat Baru",
                    titleStyle: const TextStyle(color: Colors.white),
                    content: SizedBox(
                      height: 290,
                      width: context.width,
                      child: Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListView(
                          children: [
                            TextFormField(
                              controller: controller.nomorC,
                              decoration: const InputDecoration(
                                labelText: "Nomor Surat",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nomor Surat harus diisi';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: controller.judulC,
                              decoration: const InputDecoration(
                                labelText: "Judul Surat",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Judul Surat harus diisi';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              readOnly: true,
                              // expands: true,
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  controller.tanggalC.text =
                                      DateFormat("yyyy-MM-dd")
                                          .format(selectedDate);
                                }
                              },
                              controller: controller.tanggalC,
                              decoration: const InputDecoration(
                                labelText: "Tanggal Surat",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Tanggal Surat harus diisi';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: controller.tanggal,
                              decoration: const InputDecoration(
                                labelText: "Tanggal Upload",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Tanggal Upload harus diisi';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: controller.statusC,
                              decoration: const InputDecoration(
                                labelText: "Status",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Status harus diisi';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              // enabled: false,
                              readOnly: true,
                              controller: controller.fileC,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'File harus diisi';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "File",
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.pickFile();
                              },
                              child: const Text("Ambil file"),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    buttonColor: const Color.fromARGB(15, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 83, 82, 82),
                    contentPadding: const EdgeInsets.all(10),
                    confirmTextColor: Colors.white,
                    radius: 8,
                    cancelTextColor: Colors.white,
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(15, 255, 255, 255),
                          ),
                        ),
                        onPressed: () => Get.back(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 100),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(15, 255, 255, 255),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Validasi berhasil, lakukan submit
                            await controller.createSuratKeluar(
                                controller.nomorC.text,
                                controller.judulC.text,
                                controller.tanggalC.text,
                                controller.uploadC.text,
                                controller.statusC.text,
                                controller.selectedFilePath!);
                            Get.back();
                            Get.snackbar(
                              "success",
                              duration: const Duration(seconds: 3),
                              "berhasil menambahkan surat keluar",
                              colorText: Colors.white,
                              backgroundColor: Colors.lightBlue,
                              icon: const Icon(Icons.add_alert),
                            );
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: SafeArea(
          child: FutureBuilder<List<SuratMasuk>>(
            future: controller.allSurat(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 10),
                  );
                }
              }
              return GetBuilder<SuratKeluarController>(
                builder: (controller) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    padding: const EdgeInsets.all(14),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      SuratMasuk suratMasuk = snapshot.data![index];
                      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                      String tanggal = dateFormat
                          .format(suratMasuk.tanggalSurat ?? DateTime.now());
                      return Material(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 83, 82, 82),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ExpandablePanel(
                                header: Text("${suratMasuk.noSurat}",
                                    style: GoogleFonts.prompt(
                                        color: Colors.white)),
                                collapsed: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(suratMasuk.judul!,
                                        style: GoogleFonts.prompt(
                                            color: Colors.white)),
                                    Text(tanggal,
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
                                    Text(tanggal,
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
                                            icon: const Icon(
                                                Icons.remove_red_eye)),
                                        IconButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.DETAIL_SURAT,
                                                  arguments: suratMasuk);
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              controller.hapusSurat(
                                                  suratMasuk.id.toString());

                                              Get.snackbar(
                                                "success",
                                                duration:
                                                    const Duration(seconds: 3),
                                                "berhasil menghapus surat keluar",
                                                colorText: Colors.white,
                                                backgroundColor:
                                                    Colors.lightBlue,
                                                icon:
                                                    const Icon(Icons.add_alert),
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.delete_forever)),
                                      ],
                                    ),
                                  ],
                                )),
                          ));
                    },
                  );
                },
              );
            },
          ),
        ));
  }
}
