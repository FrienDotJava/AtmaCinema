import 'dart:convert';

import 'package:http/http.dart';
import 'package:tubes/entity/Film.dart';
import 'package:tubes/entity/Studio.dart';

class StudioClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/studio';

  static Future<Map<String, dynamic>> countBookedDate(
      int id, int idFilm) async {
    final apiUrl =
        Uri.http('10.0.2.2:8000', '/api/studio/countBookedDate/$id/$idFilm');

    try {
      final response =
          await get(Uri.http(url, '$endpoint/countBookedDate/$id/$idFilm'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load seat availability');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
