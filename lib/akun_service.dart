import 'dart:convert';
import 'package:http/http.dart' as http;
import 'akun.dart';

class AkunService {
  final String baseUrl = 'http://10.0.2.2:3000/akun';

  Future<void> createAkun(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        // ignore: avoid_print
        print('Akun berhasil dibuat: ${response.body}');
      } else {
        // ignore: avoid_print
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to create akun');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception during createAkun: $e');
      throw Exception('Failed to create akun: $e');
    }
  }

  Future<void> deleteAkun(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );

      // ignore: avoid_print
      print('Delete response: ${response.statusCode} - ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete akun');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception during deleteAkun: $e');
      throw Exception('Failed to delete akun: $e');
    }
  }

  Future<void> updateAkun(String id, String name, String email) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email}),
      );

      // ignore: avoid_print
      print('Update response: ${response.statusCode} - ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update akun');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception during updateAkun: $e');
      throw Exception('Failed to update akun: $e');
    }
  }

  Future<List<Akun>> getAllAkun() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Akun.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load akun');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception during getAllAkun: $e');
      throw Exception('Failed to load akun: $e');
    }
  }
}
