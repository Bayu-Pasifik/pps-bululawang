import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class SuratKeluarController extends GetxController {
  late TextEditingController nomorC;
  late TextEditingController judulC;
  late TextEditingController tanggalC;
  late TextEditingController statusC;
  late TextEditingController uploadC;
  late TextEditingController fileC;
  late DateFormat dateFormat;
  late String tanggal;
  RxList<SuratMasuk> suratList = <SuratMasuk>[].obs;
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTY4OTI2MjUzOSwiZXhwIjozMzc4NTMyMjc4fQ.NoagX9b9oJ3LX15li9CZ89F-4GfveVbmJPfarQUTpvU';

  Future<List<SuratMasuk>> allSurat() async {
    Uri url = Uri.parse('https://apipps.kolektifhost.com/suratkeluar');
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    var tempData = json.decode(response.body);
    var data = tempData.map((e) => SuratMasuk.fromJson(e)).toList();
    suratList.value = List<SuratMasuk>.from(data);
    return suratList;
  }

  String? selectedFilePath;
  String? selectedFileName;

  Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String filePath = result.files.single.path!;
        selectedFilePath = filePath;
        selectedFileName = path.basename(filePath);
        fileC.text = selectedFileName!;
      } else {
        // User tidak memilih file
        selectedFilePath = null;
        selectedFileName = null;
      }
      return selectedFilePath;
    } catch (e) {
      // Terjadi kesalahan saat mengambil file
      print('Error picking file: $e');
      return e.toString();
    }
  }

  Future<void> createSuratKeluar(String no, String judul, String tanggalSurat,
      String tanggalUpload, String status, String filePath) async {
    try {
      Uri url = Uri.parse('https://apipps.kolektifhost.com/suratkeluar');
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['no_surat'] = no;
      request.fields['judul'] = judul;
      request.fields['tanggal_surat'] = tanggalSurat;
      request.fields['tanggal_upload'] = tanggalUpload;
      request.fields['status'] = status;
      if (filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath));
      }
      var response = await request.send();
      if (response.statusCode == 201) {
        // Permintaan sukses
        print('Surat keluar berhasil dibuat');
        await allSurat(); // Perbarui data surat keluar
        // Get.back(); // Tutup dialog
        update(); // Perbarui UI
      } else {
        // Permintaan gagal
        print(
            'Gagal membuat surat keluar. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan
      print('Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    dateFormat = DateFormat("yyyy-MM-dd");
    tanggal = dateFormat.format(DateTime.now());
    nomorC = TextEditingController();
    judulC = TextEditingController();
    tanggalC = TextEditingController();
    statusC = TextEditingController();
    fileC = TextEditingController(text: selectedFileName);
    uploadC = TextEditingController(text: tanggal);
  }
}
