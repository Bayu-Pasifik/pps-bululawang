import 'package:http/http.dart' as http;
import 'package:pps_bululawang/app/data/models/login.dart';
import 'dart:convert';

import 'package:pps_bululawang/app/data/models/surat_masuk_models.dart';

void main() async {
  String baseUrl = "https://apippslaravel.kolektifhost.com";
  String token = "";

  Uri url = Uri.parse('$baseUrl/api/login');
  var response = await http.post(url,
      body: {"email": "bayupasifik@gmail.com", "password": "bayu1234"});
  var tempData = json.decode(response.body)["user"];
  token = json.decode(response.body)["token"];
  var data = Login.fromJson(tempData);
  print(data.name);
  // suratList.value = List<SuratMasuk>.from(data);
  // return suratList;
  // return tempData;
}
