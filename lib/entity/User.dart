import 'dart:convert';

class User {
  int id_user;
  String first_name;
  String last_name;
  String email;
  String password;
  String no_telp;
  String gender;
  String tanggal_lahir;

  User({
    required this.id_user,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
    required this.no_telp,
    required this.gender,
    required this.tanggal_lahir,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id_user: json["id_user"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
        password: json["password"],
        no_telp: json["no_telp"],
        gender: json["gender"],
        tanggal_lahir: json["tanggal_lahir"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_user": id_user,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "password": password,
        "no_telp": no_telp,
        "gender": gender,
        "tanggal_lahir": tanggal_lahir,
      };
}
