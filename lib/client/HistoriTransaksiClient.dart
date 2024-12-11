import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes/entity/HistoriTransaksi.dart';

class HistoryTransaksiClient {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/histori_transaksi';

  // HistoryTransaksiClient(this.baseUrl);

  Future<List<Map<String, dynamic>>> fetchAllHistori() async {
    final url = Uri.parse('$baseUrl/histori_transaksi');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['success'] == true) {
        return List<Map<String, dynamic>>.from(body['data']);
      } else {
        throw Exception(
            'Failed to fetch histori transaksi: ${body['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch histori transaksi with status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchHistoriById(int id) async {
    final url = Uri.parse('$baseUrl/histori-transaksi/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['success'] == true) {
        return Map<String, dynamic>.from(body['data']);
      } else {
        throw Exception('Failed to fetch histori detail: ${body['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch histori detail with status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createHistori(
      int idUser, int idTransaksi) async {
    final url = Uri.parse('$baseUrl/histori-transaksi');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id_user": idUser,
        "id_transaksi": idTransaksi,
      }),
    );

    if (response.statusCode == 201) {
      final body = json.decode(response.body);
      if (body['success'] == true) {
        return Map<String, dynamic>.from(body['data']);
      } else {
        throw Exception(
            'Failed to create histori transaksi: ${body['message']}');
      }
    } else {
      final error = json.decode(response.body);
      throw Exception(
          'Failed to create histori with status: ${response.statusCode}, Error: ${error['message']}');
    }
  }
}
