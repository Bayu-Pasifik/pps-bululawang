import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_surat_controller.dart';

class TambahSuratView extends GetView<TambahSuratController> {
  const TambahSuratView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Surat Baru'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TambahSuratView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
