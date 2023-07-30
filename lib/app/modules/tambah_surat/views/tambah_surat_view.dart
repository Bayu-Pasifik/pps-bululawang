import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/tambah_surat_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahSuratView extends GetView<TambahSuratController> {
  TambahSuratView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String token = Get.arguments;
    print("Token di Tambah surat: $token");
    return Scaffold(
        backgroundColor: const Color(0XFF2E2E2E),
        appBar: AppBar(
          title: const Text('Tambah Surat Baru'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0XFF2E2E2E),
         
        ),
        body: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              TextFormField(
                controller: controller.nomorC,
                decoration: InputDecoration(
                  labelText: "Nomor Surat",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nomor Surat harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.judulC,
                decoration: InputDecoration(
                  labelText: "Judul Surat",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Judul Surat harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    controller.tanggalC.text =
                        DateFormat("yyyy-MM-dd").format(selectedDate);
                  }
                },
                controller: controller.tanggalC,
                decoration: InputDecoration(
                  labelText: "Tanggal Surat",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Surat harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.statusC,
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Status harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                readOnly: true,
                controller: controller.fileC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'File harus diisi';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "File",
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DropdownSearch<String>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Jenis Surat",
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                },
                dropdownButtonProps:
                    const DropdownButtonProps(color: Colors.white),
                popupProps: const PopupProps.dialog(
                    showSelectedItems: true,
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps()),
                asyncItems: (String filter) async {
                  Uri url = Uri.parse(
                      'https://apippslaravel.kolektifhost.com/api/jenissurat');
                  var res = await http
                      .get(url, headers: {'Authorization': 'Bearer $token'});
                  List<String> jenis = [];
                  List<String> nomor = [];
                  var jsonData = json.decode(res.body) as Map<String, dynamic>;
                  var data = jsonData['data'];
                  data.forEach((element) {
                    // controller.jenisList
                    //     .add(element['nama'].toset().toString());
                    nomor.add(element['id'].toString());
                  });

                  return nomor;
                },
                onChanged: (value) {
                  controller.jenisSurat.value = value!; // Update jenisSurat
                },
                selectedItem: controller.jenisSurat.isNotEmpty
                    ? controller.jenisSurat.value
                    : null,
              ),
              const SizedBox(height: 15),
              Text(
                "Pilih Kategori Surat",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              Obx(() => RadioListTile(
                    title: Text('Surat Masuk',
                        style: GoogleFonts.poppins(color: Colors.white)),
                    value: true,
                    groupValue: controller.isSuratMasukSelected.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.setSuratMasukSelected(value);
                      }
                    },
                  )),
              Obx(() => RadioListTile(
                    title: Text('Surat Keluar',
                        style: GoogleFonts.poppins(color: Colors.white)),
                    value: true,
                    groupValue: controller.isSuratKeluarSelected.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.setSuratKeluarSelected(value);
                      }
                    },
                  )),
              ElevatedButton(
                onPressed: () {
                  controller.pickFile();
                },
                child: Text("Ambil file",
                    style: GoogleFonts.poppins(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                
                  if(_formKey.currentState!.validate()){
                    if(controller.isSuratKeluarSelected.isTrue){
                      await controller.createSuratKeluar(
                    token,
                    controller.nomorC.text,
                    controller.judulC.text,
                    controller.tanggalC.text,
                    controller.statusC.text,
                    controller.selectedFilePath!,
                  );
                    } else {
                      await controller.createSuratMasuk(
                    token,
                    controller.nomorC.text,
                    controller.judulC.text,
                    controller.tanggalC.text,
                    controller.statusC.text,
                    controller.selectedFilePath!,
                  );
                    }
                  }
                },
                child: Text("Submit",
                    style: GoogleFonts.poppins(color: Colors.white)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
