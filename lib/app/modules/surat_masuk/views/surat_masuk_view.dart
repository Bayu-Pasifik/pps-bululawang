import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';

import '../controllers/surat_masuk_controller.dart';

class SuratMasukView extends GetView<SuratMasukController> {
  const SuratMasukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF2E2E2E),
        appBar: AppBar(
          backgroundColor: const Color(0XFF2E2E2E),
          title: const Text('Surat Masuk'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: FutureBuilder(
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
              return ListView.builder(
                padding: const EdgeInsets.all(14),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  SuratMasuk suratMasuk = snapshot.data![index];
                  return Material(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 83, 82, 82),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0XFF2E2E2E),
                        child: Text("${index + 1}"),
                      ),
                      title: Text(
                        "${suratMasuk.noSurat}",
                        style: GoogleFonts.prompt(color: Colors.white),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${suratMasuk.judul}",
                              style: GoogleFonts.prompt(color: Colors.white)),
                          Text("${suratMasuk.tanggalSurat}",
                              style: GoogleFonts.prompt(color: Colors.white))
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
