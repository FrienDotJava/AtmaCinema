import 'dart:convert';

class Review {
  int id_review;
  int id_film;
  int id_user;
  int rating_review;
  String deskripsi_review;

  Review({
    required this.id_review,
    required this.id_film,
    required this.id_user,
    required this.rating_review,
    required this.deskripsi_review,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id_review: json["id_review"],
        id_film: json["id_film"],
        id_user: json["id_user"],
        rating_review: json["rating_review"],
        deskripsi_review: json["deskripsi_review"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_review": id_review,
        "id_film": id_film,
        "id_user": id_user,
        "rating_review": rating_review,
        "deskripsi_review": deskripsi_review,
      };
}
