import 'dart:convert';
import 'package:http/http.dart';
import 'package:tubes/entity/Transaksi.dart';

class TransaksiClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/transaksi';

  static Future<int?> storeTransaksi(int? id_user, double? total_harga, String? status, String? token) async {
    print('Sending POST request to $url$endpoint');
    print('Headers: {Content-Type: application/json, Authorization: Bearer $token}');
    print('Body: ${json.encode({'id_user': id_user, 'total_harga': total_harga, 'status': status})}');
    try {
      final response = await post(
        Uri.http(url, endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'id_user': id_user,
          'total_harga': total_harga,
          'status': status,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final int idTransaksi = responseData['data']['id_transaksi'];

        return idTransaksi;
      } else {
        print('Failed to store data: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}