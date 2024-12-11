import 'dart:convert';
import 'JadwalTayang.dart';

class Tiket {
  int? id_tiket;
  int id_transaksi;
  int id_jadwal;
  int jumlah_kursi;
  String? status;
  int id_user;
  String? jamTayang;
  String? tanggal;
  String? judulFilm;
  String? poster;
  String? format;
  int? noStudio;

  Tiket({
    this.id_tiket,
    required this.id_transaksi,
    required this.id_jadwal,
    required this.jumlah_kursi,
    this.status,
    required this.id_user,
    this.jamTayang,
    this.tanggal,
    this.judulFilm,
    this.poster,
    this.format,
    this.noStudio,
  });

  factory Tiket.fromRawJson(String str) => Tiket.fromJson(json.decode(str));

  factory Tiket.fromJson(Map<String, dynamic> json) => Tiket(
        id_tiket: json["id_tiket"],
        id_transaksi: json["id_transaksi"],
        id_jadwal: json["id_jadwal"],
        jumlah_kursi: json["jumlah_kursi"],
        id_user: json["id_user"],
        jamTayang: json["jadwal_tayang"]?["jam_tayang"],
        tanggal: json["jadwal_tayang"]?["tanggal"],
        judulFilm: json["jadwal_tayang"]?["film"]?["judul_film"],
        poster: json["jadwal_tayang"]?["film"]?["poster"],
        format: json["jadwal_tayang"]?["film"]?["dimensi"],
        noStudio: json["jadwal_tayang"]?["studio"]?["nomor_studio"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_tiket": id_tiket,
        "id_transaksi": id_transaksi,
        "id_jadwal": id_jadwal,
        "jumlah_kursi": jumlah_kursi,
        "status": status,
        "id_user": id_user,
        "jamTayang": jamTayang,
        "tanggal": tanggal,
        "judulFilm": judulFilm,
        "poster": poster,
        "format": format,
        "noStudio": noStudio,
      };
}
