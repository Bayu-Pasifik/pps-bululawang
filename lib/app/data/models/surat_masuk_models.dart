// To parse this JSON data, do
//
//     final suratMasuk = suratMasukFromJson(jsonString);

import 'dart:convert';

SuratMasuk suratMasukFromJson(String str) =>
    SuratMasuk.fromJson(json.decode(str));

String suratMasukToJson(SuratMasuk data) => json.encode(data.toJson());

class SuratMasuk {
  int? id;
  String? uid;
  String? noSurat;
  String? judul;
  String? tanggalSurat;
  String? status;
  String? file;
  String? fileName;
  String? jenisSurat;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? namaJenis;

  SuratMasuk({
    this.id,
    this.uid,
    this.noSurat,
    this.judul,
    this.tanggalSurat,
    this.status,
    this.file,
    this.fileName,
    this.jenisSurat,
    this.createdAt,
    this.updatedAt,
    this.namaJenis,
  });

  factory SuratMasuk.fromJson(Map<String, dynamic> json) => SuratMasuk(
        id: json["id"],
        uid: json["uid"],
        noSurat: json["no_surat"],
        judul: json["judul"],
        tanggalSurat: json["tanggal_surat"],
        status: json["status"],
        file: json["file"],
        fileName: json["fileName"],
        jenisSurat: json["jenis_surat"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        namaJenis: json["nama_jenis"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "no_surat": noSurat,
        "judul": judul,
        "tanggal_surat": tanggalSurat,
        "status": status,
        "file": file,
        "fileName": fileName,
        "jenis_surat": jenisSurat,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "nama_jenis": namaJenis,
      };
}
