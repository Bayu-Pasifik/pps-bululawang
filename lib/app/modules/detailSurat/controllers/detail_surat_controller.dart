import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:pps_bululawang/app/modules/surat_keluar/controllers/surat_keluar_controller.dart';

class DetailSuratController extends GetxController {
  // String token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTY4OTI2MjUzOSwiZXhwIjozMzc4NTMyMjc4fQ.NoagX9b9oJ3LX15li9CZ89F-4GfveVbmJPfarQUTpvU';
  // ! get surat by id
  List<int>? fileBytes;
  Future<SuratMasuk> getSuratById(String id, String token) async {
    Uri url = Uri.parse('https://apipps.kolektifhost.com/suratkeluar/$id');
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    var tempData = json.decode(response.body);
    var data = SuratMasuk.fromJson(tempData);
    print(data.file);
    // Check if the 'file' field is present in the response
    if (data.file != null) {
      // Download the file and store it as a List<int>
      fileBytes = await _downloadFile(data.file!);
      print(fileBytes);
      //data.fileBytes = fileBytesList;
      // return fileBytesList;
    }

    return data;
  }

  // Function to download the file and store it as a List<Bytes>
  Future<List<int>> _downloadFile(String fileUrl) async {
    try {
      var response = await http.get(Uri.parse(fileUrl));
      print(response.body);
      if (response.statusCode == 200) {
        // File downloaded successfully
        List<int> fileBytes = response.bodyBytes;
        return fileBytes;
      } else {
        // Failed to download the file
        print(
            'Failed to download the file. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Error occurred while downloading the file
      print('Error downloading the file: $e');
      return [];
    }
  }

  final suratController = Get.put(SuratKeluarController());
  late TextEditingController nomorC;
  late TextEditingController judulC;
  late TextEditingController tanggalC;
  late TextEditingController statusC;
  late TextEditingController uploadC;
  late TextEditingController fileC;
  late DateFormat dateFormat;
  late String tanggal;
  bool isNewFileSelected = false;

  String selectedFilePath = ""; // Initialize with an empty string
  String? selectedFileName;
  File? selectedFile;

  Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String filePath = result.files.single.path!;
        selectedFile = File(filePath);
        if (selectedFile!.existsSync()) {
          selectedFilePath = filePath;
          selectedFileName = path.basename(filePath);
          fileC.text = selectedFileName!;
          isNewFileSelected =
              true; // Set the flag to true when a new file is selected
          print(fileC.text);
        } else {
          // The selected file does not exist
          print('Error: The selected file does not exist.');
          selectedFilePath = "";
          selectedFileName = null;
          isNewFileSelected =
              false; // Set the flag to false when no new file is selected
        }
      } else {
        // User canceled file selection
        selectedFilePath = "";
        selectedFileName = null;
        isNewFileSelected =
            false; // Set the flag to false when no new file is selected
      }
      return selectedFilePath;
    } catch (e) {
      // Terjadi kesalahan saat mengambil file
      print('Error picking file: $e');
      return e.toString();
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
    fileC = TextEditingController(text: selectedFileName ?? "");
    uploadC = TextEditingController(text: tanggal);
  }

  Future<void> updateSuratKeluar(
    String token,
    String id,
    String no,
    String judul,
    String tanggalSurat,
    String tanggalUpload,
    String status,
    File? newFile,
    String? oldFileName,
    // bool isNewFileSelected, // Add the isNewFileSelected parameter
  ) async {
    try {
      Uri url = Uri.parse('https://apipps.kolektifhost.com/suratkeluar/$id');
      var request = http.MultipartRequest('PATCH', url);

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['no_surat'] = no;
      request.fields['judul'] = judul;
      request.fields['tanggal_surat'] = tanggalSurat;
      request.fields['tanggal_upload'] = tanggalUpload;
      request.fields['status'] = status;

      if (newFile != null) {
        // If a new file is chosen, add it to the request as MultipartFile
        request.files
            // .add(await http.MultipartFile.fromPath('file', newFile.path));
            .add(http.MultipartFile.fromBytes('file', fileBytes!));
      } else if (oldFileName != null) {
        // If no new file is chosen, but there's an old file, add it to the request as MultipartFile
        var oldFile = File(oldFileName);
        if (oldFile.existsSync()) {
          request.files
              .add(await http.MultipartFile.fromPath('file', oldFile.path));
        }
      }
      print("file dalam request file: ${request.files}");
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // Permintaan sukses

        // await suratController.allSurat(); // Perbarui data surat keluar
        update();
        // Perbarui UI
        Get.back();
        Get.snackbar(
          "Success",
          duration: const Duration(seconds: 3),
          "Berhasil Mengubah Surat Keluar",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
        );
      } else {
        // Permintaan gagal
        Get.snackbar(
          "Gagal",
          duration: const Duration(seconds: 3),
          "Gagal mengubah surat keluar. Status code: ${response.statusCode}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
        print(
            'Gagal mengubah surat keluar. Status code: ${response.statusCode}');
        print('Response Data: $responseData');
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan
      print('Error: $e');
      Get.snackbar(
        "Gagal",
        duration: const Duration(seconds: 3),
        "Gagal mengubah surat keluar. Error: $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.add_alert),
      );
    }
  }
}
