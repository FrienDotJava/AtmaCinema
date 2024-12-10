import 'dart:convert';
import 'JadwalTayang.dart';

class Tiket {
  int? id_tiket;
  int id_transaksi;
  int id_jadwal;
  int jumlah_kursi;
  String? status;
  int id_user;

  Tiket({
    this.id_tiket,
    required this.id_transaksi,
    required this.id_jadwal,
    required this.jumlah_kursi,
    this.status,
    required this.id_user,
  });

  factory Tiket.fromRawJson(String str) => Tiket.fromJson(json.decode(str));
  factory Tiket.fromJson(Map<String, dynamic> json) => Tiket(
      id_tiket: json["id_tiket"],
      id_transaksi: json["id_transaksi"],
      id_jadwal: json["id_jadwal"],
      jumlah_kursi: json["jumlah_kursi"],
      id_user: json["id_user"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_tiket": id_tiket,
        "id_transaksi": id_transaksi,
        "id_jadwal": id_jadwal,
        "jumlah_kursi": jumlah_kursi,
        "id_user": id_user
      };

  String calculateStatus(Jadwaltayang jadwal, int filmDuration) {
    final DateTime jadwalTime =
        DateTime.parse('${jadwal.tanggal} ${jadwal.jadwal_tayang}');
    final DateTime endTime = jadwalTime.add(Duration(minutes: filmDuration));

    if (DateTime.now().isAfter(endTime)) {
      return "History";
    }
    return "On Progress";
  }
}
