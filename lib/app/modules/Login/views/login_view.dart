import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pps_bululawang/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(20), children: [
            TextFormField(
              controller: controller.emailC,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email harus diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.passwordC,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'password harus diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await controller.login(
                        controller.emailC.text, controller.passwordC.text);
                    Get.offNamed(Routes.HOME, arguments: controller.token);
                  }
                },
                child: Text("Login"))
          ]),
        ));
  }
}
