import 'dart:convert';

class Tiket {
  int id_tiket;
  int id_transaksi;
  int id_jadwal;
  int nomor_kursi;

  Tiket({
    required this.id_tiket,
    required this.id_transaksi,
    required this.id_jadwal,
    required this.nomor_kursi,
  });

  factory Tiket.fromRawJson(String str) => Tiket.fromJson(json.decode(str));
  factory Tiket.fromJson(Map<String, dynamic> json) => Tiket(
        id_tiket: json["id_tiket"],
        id_transaksi: json["id_transaksi"],
        id_jadwal: json["id_jadwal"],
        nomor_kursi: json["nomor_kursi"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_tiket": id_tiket,
        "id_transaksi": id_transaksi,
        "id_jadwal": id_jadwal,
        "nomor_kursi": nomor_kursi,
      };
}
