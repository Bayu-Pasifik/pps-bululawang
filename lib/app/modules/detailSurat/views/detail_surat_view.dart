import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';

import '../controllers/detail_surat_controller.dart';

class DetailSuratView extends GetView<DetailSuratController> {
  DetailSuratView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final SuratMasuk surat = Get.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0XFF2E2E2E),
        appBar: AppBar(
          backgroundColor: const Color(0XFF2E2E2E),
          elevation: 0,
          title: Text('Detail ${surat.judul}'),
          centerTitle: true,
        ),
        body: FutureBuilder<SuratMasuk>(
          // future: controller.getSuratById(surat.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 10),
              );
            }
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
            SuratMasuk suratMasuk = snapshot.data!;
            controller.tanggalC.text = suratMasuk.tanggalSurat!;
            // DateFormat("yyyy-MM-dd").format();
            return SafeArea(
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    TextFormField(
                      controller: controller.nomorC..text = suratMasuk.noSurat!,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Nomor Surat",
                          labelStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nomor Surat harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.judulC..text = suratMasuk.judul!,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Judul Surat",
                          labelStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Judul Surat harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      readOnly: true,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(suratMasuk.tanggalSurat!),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          controller.tanggalC.text =
                              DateFormat("yyyy-MM-dd").format(selectedDate);
                        }
                      },
                      controller: controller.tanggalC,
                      decoration: const InputDecoration(
                          labelText: "Tanggal Surat",
                          labelStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tanggal Surat harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: controller.tanggal,
                      decoration: const InputDecoration(
                        labelText: "Tanggal Upload",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tanggal Upload harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: controller.statusC
                        ..text = suratMasuk.status.toString(),
                      decoration: const InputDecoration(
                        labelText: "Status",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Status harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      readOnly: true,
                      //initialValue: ,
                      controller: controller.fileC..text = suratMasuk.fileName!,
                      decoration: const InputDecoration(
                        labelText: "File",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.pickFile();
                      },
                      child: const Text("Ambil file"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Validasi berhasil, lakukan submit
                          // await controller.updateSuratKeluar(
                          //     suratMasuk.id.toString(),
                          //     controller.nomorC.text,
                          //     controller.judulC.text,
                          //     controller.tanggalC.text,
                          //     controller.uploadC.text,
                          //     controller.statusC.text,
                          //     controller.selectedFile,
                          //     suratMasuk.fileName);
                          Get.back();
                          Get.snackbar(
                            "success",
                            duration: const Duration(seconds: 3),
                            "berhasil Mengubah surat keluar",
                            colorText: Colors.white,
                            backgroundColor: Colors.lightBlue,
                            icon: const Icon(Icons.add_alert),
                          );
                        }
                      },
                      child: const Text("Edit"),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
