import 'dart:convert';

import 'package:http/http.dart';
import 'package:tubes/entity/Film.dart';

class FilmClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/film';

  // Fungsi untuk mengambil data film berdasarkan status (Now Playing atau Coming Soon)
  static Future<List<Film>> fetchByStatus(String status, String token) async {
    try {
      final response = await get(Uri.http(url, '$endpoint/status/$status'),
          headers: {'Authorization': 'Bearer $token'}); //Buat ngambil token
      //Wajib karena semua fungsi di backend butuh token -> auth sanctum

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Film.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Fungsi untuk mengambil jadwal film berdasarkan ID film
  static Future<Map<String, dynamic>> getFilmSchedule(int filmId) async {
    final response = await get(Uri.http(url, '$endpoint/schedule/$filmId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load film schedule');
    }
  }

  // Fungsi untuk mengambil detail film berdasarkan ID
  static Future<Film> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];

      return Film.fromJson(data);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Fungsi untuk handle search movie
  static Future<List<Film>> searchMovies(
      String query, String status, String token) async {
    try {
      final response = await get(
        Uri.http(url, '$endpoint/search', {'query': query, 'status': status}),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final data = json.decode(response.body);
      final films =
          (data['data'] as List).map((film) => Film.fromJson(film)).toList();

      return films;
    } catch (e) {
      return Future.error('Failed to search movies: $e');
    }
  }
}
