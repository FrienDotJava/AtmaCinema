import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes/entity/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserClient {
  static final String url = 'http://10.0.2.2:8000';
  static final String endpoint = '/api';

  // Fungsi untuk mendaftarkan email pengguna
  static Future<bool> registerEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$url/api/register/email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to register email: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Fungsi untuk mengirim data registrasi pengguna
  static Future<bool> registerUser(User user) async {
    final Uri apiUrl = Uri.parse('$url$endpoint/register/data');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'first_name': user.first_name,
          'last_name': user.last_name,
          'email': user.email,
          'password': user.password,
          'no_telp': user.no_telp,
          'gender': user.gender,
          'tanggal_lahir': user.tanggal_lahir,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to register: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<User> login(String email, String password) async {
    final Uri apiUrl = Uri.parse('$url/api/login');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true) {
          String token = data['data']['token'];

          // Simpan token setelah login
          await saveToken(token);

          // Kembalikan User object
          return User.fromRawJson(json.encode(data['data']['user']), token);
        } else {
          throw Exception('Invalid credentials');
        }
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<User?> getProfile(String token) async {
    final Uri apiUrl = Uri.parse('$url/api/user/profile');
    try {
      final response = await http.get(
        apiUrl,
        headers: {'Authorization': 'Bearer $token'}, //Buat ngambil token
        //Wajib karena semua fungsi di backend butuh token -> auth sanctum
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return User.fromRawJson(json.encode(data['data']), token);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<bool> updateProfile(String token,
      String first_name, String last_name, String no_telp, String gender, String tanggal_lahir) async {
    final Uri apiUrl = Uri.parse('$url/api/user/profile');
    try {
      final response = await http.put(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Mengirim token untuk autentikasi
        },
        body: json.encode({
          'first_name': first_name,
          'last_name': last_name,
          'no_telp': no_telp,
          'gender': gender,
          'tanggal_lahir': tanggal_lahir,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update profile: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<String?> logout(String token) async {
    final Uri apiUrl = Uri.parse('$url/api/logout');
    try {
      final response = await http.post(
        apiUrl,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return "Logout Success";
      } else if (response.statusCode == 401) {
        return "Unauthorized: Please log in again.";
      } else {
        return "Failed to logout: ${response.body}";
      }
    } catch (e) {
      print('Error: $e');
      return "An error occurred while logging out.";
    }
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  //Cuma buat debug aja (pakai nek ngebug -> null)
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("Token retrieved: $token");
    return token;
  }
}
