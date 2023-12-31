import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SuratKeluarController extends GetxController {
  RefreshController refreschcontroller =
      RefreshController(initialRefresh: true);
  RxList<SuratMasuk> suratList = <SuratMasuk>[].obs;
  String baseUrl = "https://apippslaravel.kolektifhost.com";
  final token = Get.arguments;
  Future<List<SuratMasuk>> allSurat(String token) async {
    Uri url = Uri.parse('$baseUrl/api/suratkeluar');
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    var tempData = json.decode(response.body)["data"];
    update();
    var data = tempData.map((e) => SuratMasuk.fromJson(e)).toList();
    // suratList.value = List<SuratMasuk>.from(data);
    var listSurat = List<SuratMasuk>.from(data);
    suratList.assignAll(listSurat);
    update();
    return suratList;
  }

  String? selectedFilePath;
  String? selectedFileName;

  // ! delete data
  Future<void> hapusSurat(String token, String id) async {
    Uri url = Uri.parse('$baseUrl/api/suratkeluar/$id');
    final response =
        await http.delete(url, headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      await allSurat(token); // Perbarui data surat keluar
      update();
      Get.snackbar(
        "Berhasil",
        duration: const Duration(seconds: 3),
        "Berhasil menghapus data",
        colorText: Colors.white,
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.mail),
      );
      print('Data berhasil dihapus');
    } else {
      // Gagal menghapus data
      print('Gagal menghapus data. Status code: ${response.statusCode}');
      Get.snackbar(
        "Gagal",
        duration: const Duration(seconds: 3),
        "Gagal menghapus surat : ${response.statusCode}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.mail),
      );
    }
  }

  // ! download dan baca data
  void downloadAndView(String fileUrl) async {
    try {
      // Mendapatkan direktori temporary
      Directory tempDir = await getTemporaryDirectory();

      // Mengambil data file dari URL
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        // Simpan data file dalam bentuk bytes
        List<int> fileBytes = response.bodyBytes;

        // Simpan data file dalam file temporary
        File tempFile = File('${tempDir.path}/temp_file');
        await tempFile.writeAsBytes(fileBytes);

        // Buka file menggunakan package open_file
        var open = await OpenFilex.open(tempFile.path);
        print("openfilex = ${open.message}");
      } else {
        print(
            'Error: Gagal mengambil data file dari URL. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void refreshData(String token) async {
    if (refreschcontroller.initialRefresh == true) {
      await allSurat(token);
      update();
      return refreschcontroller.refreshCompleted();
    } else {
      return refreschcontroller.refreshFailed();
    }
  }
}
