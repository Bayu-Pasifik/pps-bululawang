// To parse this JSON data, do
//
//     final suratMasuk = suratMasukFromJson(jsonString);

import 'dart:convert';

SuratMasuk suratMasukFromJson(String str) =>
    SuratMasuk.fromJson(json.decode(str));

String suratMasukToJson(SuratMasuk data) => json.encode(data.toJson());

class SuratMasuk {
  int? id;
  String? noSurat;
  String? judul;
  DateTime? tanggalSurat;
  String? tanggalUpload;
  int? status;
  String? file;
  String? fileName;

  SuratMasuk({
    this.id,
    this.noSurat,
    this.judul,
    this.tanggalSurat,
    this.tanggalUpload,
    this.status,
    this.file,
    this.fileName,
  });

  factory SuratMasuk.fromJson(Map<String, dynamic> json) => SuratMasuk(
        id: json["id"],
        noSurat: json["no_surat"],
        judul: json["judul"],
        tanggalSurat: json["tanggal_surat"] == null
            ? null
            : DateTime.parse(json["tanggal_surat"]),
        tanggalUpload: json["tanggal_upload"],
        status: json["status"],
        file: json["file"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_surat": noSurat,
        "judul": judul,
        "tanggal_surat":
            "${tanggalSurat!.year.toString().padLeft(4, '0')}-${tanggalSurat!.month.toString().padLeft(2, '0')}-${tanggalSurat!.day.toString().padLeft(2, '0')}",
        "tanggal_upload": tanggalUpload,
        "status": status,
        "file": file,
        "fileName": fileName,
      };
}
