import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:pps_bululawang/app/modules/surat_keluar/controllers/surat_keluar_controller.dart';

class TambahSuratController extends GetxController {
  late TextEditingController nomorC;
  late TextEditingController judulC;
  late TextEditingController tanggalC;
  late TextEditingController statusC;
  late TextEditingController fileC;
  late TextEditingController jenisC;
  RxString jenisSurat = ''.obs;
  RxBool isSuratMasukSelected = true.obs;
  RxBool isSuratKeluarSelected = false.obs;
  List<String> jenisList = [];
  List<String> nomorList = [];
  // List<String> selectedJenisIds = [].obs;
  RxList<String> selectedJenisIds = <String>[].obs;
  void updateSelectedJenisId(String selectedJenisSurat) {
    final selectedIndex = jenisSurat.indexOf(selectedJenisSurat);
    if (selectedIndex >= 0) {
      selectedJenisIds.value = [nomorList[selectedIndex]];
    } else {
      selectedJenisIds.value = []; // Set to empty if not found
    }
  }

  // var isSuratMasukSelected = true.obs;
  // var isSuratKeluarSelected = false.obs;

  void setSuratMasukSelected(bool value) {
    isSuratMasukSelected.value = value;
    if (value) {
      isSuratKeluarSelected.value = false;
    }
  }

  void setSuratKeluarSelected(bool value) {
    isSuratKeluarSelected.value = value;
    if (value) {
      isSuratMasukSelected.value = false;
    }
  }

  String? selectedFilePath;
  String? selectedFileName;
  String baseUrl = "https://apippslaravel.kolektifhost.com";
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

  Future<void> createSuratKeluar(String token, String no, String judul,
      String tanggalSurat, String status, String filePath) async {
    try {
      Uri url = Uri.parse('$baseUrl/api/suratkeluar');
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['no_surat'] = no;
      request.fields['judul'] = judul;
      request.fields['tanggal_surat'] = tanggalSurat;
      request.fields['status'] = status;
      if (filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath));
      }
      request.fields['jenis_surat'] = jenisSurat.value;

      var response = await request.send();
      print(request.fields);
      print(request.files.length);
      print(response.statusCode);
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          "success",
          duration: const Duration(seconds: 3),
          "berhasil menambahkan surat keluar",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.mail),
        );
      } else {
        // Permintaan gagal
        Get.snackbar(
          "Gagal",
          duration: const Duration(seconds: 3),
          "Gagal menambahkan surat keluar status kode : ${response.statusCode}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.mail),
        );
        print(
            'Gagal membuat surat keluar. Status code: ${response.statusCode}');
        // Get.back();
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan
      Get.snackbar(
        "Gagal",
        duration: const Duration(seconds: 3),
        "Terjadi Kesalahan saat menambahkan surat keluar . Error : $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.mail),
      );
      print('Error: $e');
      // Get.back();
    }
  }

  // ! buat surat masuk

  Future<void> createSuratMasuk(String token, String no, String judul,
      String tanggalSurat, String status, String jenis, String filePath) async {
    try {
      Uri url = Uri.parse('$baseUrl/api/suratmasuk');
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['no_surat'] = no;
      request.fields['judul'] = judul;
      request.fields['tanggal_surat'] = tanggalSurat;
      request.fields['status'] = status;
      if (filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath));
      }
      request.fields['jenis_surat'] = jenis;
      var response = await request.send();
      if (response.statusCode == 201) {
        // Permintaan sukses

        Get.snackbar(
          "success",
          duration: const Duration(seconds: 3),
          "berhasil menambahkan surat Masuk",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.mail),
        );
        Get.back();
      } else {
        Get.snackbar(
          "Gagal",
          duration: const Duration(seconds: 3),
          "Gagal menambahkan surat Masuk ${response.statusCode}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.mail),
        );
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        "Gagal",
        duration: const Duration(seconds: 3),
        "Terjadi kesalahan saat menambahkan surat masuk $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.mail),
      );
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
    nomorC = TextEditingController();
    judulC = TextEditingController();
    tanggalC = TextEditingController();
    statusC = TextEditingController();
    fileC = TextEditingController();
    jenisC = TextEditingController();
  }

  void clear() {
    nomorC.clear();
    judulC.clear();
    tanggalC.clear();
    statusC.clear();
    fileC.clear();
    jenisC.clear();
  }

  @override
  void dispose() {
    super.dispose();
    nomorC.dispose();
    judulC.dispose();
    tanggalC.dispose();
    statusC.dispose();
    fileC.dispose();
    jenisC.dispose();
    clear();
    Get.put(SuratKeluarController());
  }

  @override
  void onClose() {
    Get.put(SuratKeluarController());
    super.onClose();
  }
}
