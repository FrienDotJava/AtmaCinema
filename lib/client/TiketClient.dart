import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tubes/entity/Tiket.dart';
import 'package:tubes/entity/JadwalTayang.dart';
import 'FilmClient.dart';

class TiketClient {
  static const String _baseUrl = '10.0.2.2:8000';
  static const String _endpoint = '/api/tiket';

  /// Fetch tickets by user ID and compute the `status`

  static Future<List<Tiket>> fetchByUser(
      int? userId, String token, int? idFilm) async {
    try {
      // Step 1: Fetch Tikets
      final response = await http.get(
        Uri.http(_baseUrl, '$_endpoint/user/$userId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        print(Tiket);
        throw Exception('Failed to fetch tickets: ${response.reasonPhrase}');
      }

      // Step 2: Map JSON response to Tiket objects
      Iterable jsonList = json.decode(response.body)['data'];

      List<Tiket> tikets = [];

      for (var data in jsonList) {
        Tiket tiket = Tiket.fromJson(data);

        // Step 3: Fetch the film schedule for the specific film
        Map<String, dynamic> jadwalData =
            await FilmClient.getFilmSchedule(idFilm!, null);

        // Assuming jadwalData contains the necessary information
        Jadwaltayang jadwal = Jadwaltayang.fromJson(jadwalData);

        // Default film duration to 120 minutes (2 hours)
        int filmDuration = 120;

        // Calculate the status
        tiket.status = tiket.calculateStatus(jadwal, filmDuration);

        tikets.add(tiket);
      }

      return tikets;
    } catch (e) {
      return Future.error('Error fetching tickets: $e');
    }
  }

  static Future<Tiket> find(int id, String token, Jadwaltayang jadwal) async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, '$_endpoint/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch ticket: ${response.reasonPhrase}');
      }

      final jsonData = json.decode(response.body)['data'];
      Tiket tiket = Tiket.fromJson(jsonData);

      // Default film duration to 120 minutes (2 hours)
      int filmDuration = 120;

      // Calculate and assign the status
      tiket.status = tiket.calculateStatus(jadwal, filmDuration);

      return tiket;
    } catch (e) {
      return Future.error('Error fetching ticket: $e');
    }
  }

  /// Create a new ticket
  static Future<Tiket> create(
      Map<String, dynamic> tiketData, String? token) async {
    try {
      print("Sending POST request to: $_baseUrl$_endpoint");
      print("Headers: {Content-Type: application/json, Authorization: Bearer $token}");
      print("Body: ${json.encode(tiketData)}");
      final response = await post(
        Uri.http(_baseUrl, _endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(tiketData),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to create ticket: ${response.reasonPhrase}');
      }

      final jsonData = json.decode(response.body)['data'];
      return Tiket.fromJson(jsonData);
    } catch (e) {
      return Future.error('Error creating ticket: $e');
    }
  }

  /// Update an existing ticket by ID
  static Future<Tiket> update(
      int id, Map<String, dynamic> tiketData, String token) async {
    try {
      final response = await http.put(
        Uri.http(_baseUrl, '$_endpoint/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(tiketData),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update ticket: ${response.reasonPhrase}');
      }

      final jsonData = json.decode(response.body)['data'];
      return Tiket.fromJson(jsonData);
    } catch (e) {
      return Future.error('Error updating ticket: $e');
    }
  }

  /// Delete a ticket by ID
  static Future<void> delete(int id, String token) async {
    try {
      final response = await http.delete(
        Uri.http(_baseUrl, '$_endpoint/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete ticket: ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error('Error deleting ticket: $e');
    }
  }
}
