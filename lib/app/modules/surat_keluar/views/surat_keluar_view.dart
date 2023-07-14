import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/surat_keluar_controller.dart';

class SuratKeluarView extends GetView<SuratKeluarController> {
  const SuratKeluarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SuratKeluarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SuratKeluarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
