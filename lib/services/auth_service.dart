import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String firebaseApiKey = 'AIzaSyDIsIuS_rnX3Bp6cdlv3f0a9YrLLrWZnuU';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi registrasi
  Future<Map<String, dynamic>> register(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseApiKey');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Menyimpan data pengguna ke Firestore
        await _firestore.collection('users').doc(data['localId']).set({
          'email': email,
          'createdAt': DateTime.now(),
        });

        return data;
      } else {
        final error = json.decode(response.body);
        return {'error': error['error']['message']};
      }
    } catch (e) {
      return {'error': 'Terjadi kesalahan: $e'};
    }
  }

  // Fungsi login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseApiKey');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Data login berhasil
      } else {
        final error = json.decode(response.body);
        return {'error': error['error']['message']};
      }
    } catch (e) {
      return {'error': 'Terjadi kesalahan: $e'};
    }
  }
}
