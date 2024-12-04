import 'dart:convert';

import 'package:http/http.dart';
import 'package:tubes/entity/Tiket.dart';

class TiketClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/tiket';

  // Fungsi untuk mengambil daftar tiket berdasarkan user
  static Future<List<Tiket>> fetchByUser(int userId, String token) async {
    try {
      final response = await get(
        Uri.http(url, '$endpoint/user/$userId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Tiket.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Fungsi untuk mengambil detail tiket berdasarkan ID
  static Future<Tiket> find(int id, String token) async {
    try {
      final response = await get(
        Uri.http(url, '$endpoint/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];

      return Tiket.fromJson(data);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Fungsi untuk membuat tiket baru
  static Future<Tiket> create(
      Map<String, dynamic> tiketData, String token) async {
    try {
      final response = await post(
        Uri.http(url, endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(tiketData),
      );

      if (response.statusCode != 201) {
        throw Exception(response.reasonPhrase);
      }

      final data = json.decode(response.body)['data'];
      return Tiket.fromJson(data);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Fungsi untuk mengupdate tiket berdasarkan ID
  static Future<Tiket> update(
      int id, Map<String, dynamic> tiketData, String token) async {
    try {
      final response = await put(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(tiketData),
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final data = json.decode(response.body)['data'];
      return Tiket.fromJson(data);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Fungsi untuk menghapus tiket berdasarkan ID
  static Future<void> delete(int id, String token) async {}
}
