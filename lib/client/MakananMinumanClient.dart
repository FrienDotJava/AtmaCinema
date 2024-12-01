import 'dart:convert';
import 'package:http/http.dart';
import 'package:tubes/entity/MakananMinuman.dart';

class MakananMinumanClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/makanan_minuman';

  static Future<List<Makananminuman>> fetchByKategori(String kategori, String token) async {
    try {
      final response = await get(
        Uri.http(url, '$endpoint/kategori/$kategori'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final decodedResponse = json.decode(response.body);
      print(decodedResponse); // Log the entire response body

      Iterable list = decodedResponse['data'];

      return list.map((e) => Makananminuman.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Makananminuman> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];

      return Makananminuman.fromJson(data);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
