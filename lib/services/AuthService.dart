import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static bool isLoggedIn = false;
  static String? token;
  static String? username;

  // Appel API pour vérifier login + mot de passe
  static Future<bool> login(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://api/auth/login'), // Mon lien pour l'api 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': login,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token = data['token'];       //  stocker le token retourné
        username = data['username']; 
        isLoggedIn = true;
        return true;
      } else {
        isLoggedIn = false;
        return false;
      }
    } catch (e) {
      isLoggedIn = false;
      return false;
    }
    
  }

  static void logout() {
    isLoggedIn = false;
    token = null;
    username = null;
  } 
  
}