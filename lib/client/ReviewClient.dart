import 'dart:convert';
import 'package:http/http.dart';
import 'package:tubes/entity/Review.dart';

class ReviewClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/review';

  static Future<ResponseReview> fetchReview(int idFilm, String? token) async {
    try {
      final response = await get(
        Uri.http(url, '$endpoint/$idFilm'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];

      return ResponseReview.fromJson(data);
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  static Future<bool> storeReview(int idFilm, int idUser, int ratingReview,
      String description, String? token) async {
    try {
      final response = await post(
        Uri.http(url, endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'id_film': idFilm,
          'id_user': idUser,
          'rating_review': ratingReview,
          'deskripsi_review': description,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Review successfully added.");
        return true;
      } else {
        print("Failed to add review: ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      print("Error occurred: ${e.toString()}");
      return Future.error(e.toString());
    }
  }
}
