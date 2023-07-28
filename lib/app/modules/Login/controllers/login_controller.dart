import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pps_bululawang/app/data/models/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;
  String baseUrl = "https://apippslaravel.kolektifhost.com";
  String? token = "";
  Future<Login> login(String email, String password) async {
    Uri url = Uri.parse('$baseUrl/api/login');
    var response =
        await http.post(url, body: {"email": email, "password": password});
    var tempData = json.decode(response.body)["user"];
    print("ini data :$tempData");
    token = json.decode(response.body)["token"];
    print("ini token :$token");
    var data = Login.fromJson(tempData);
    return data;
  }

  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passwordC = TextEditingController();
  }
}
