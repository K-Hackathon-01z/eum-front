import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/user/user_signup_request.dart';

class AuthService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  Future<bool> requestEmailCode(String email) async {
    final url = Uri.parse('$base/api/auth/email/request');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );
    return response.statusCode == 200;
  }

  Future<bool> confirmEmailCode(String email, String code) async {
    final url = Uri.parse('$base/api/auth/email/confirm');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'code': code}),
    );
    return response.statusCode == 200;
  }

  Future<bool> signup(UserSignupRequest request) async {
    final url = Uri.parse('$base/api/auth/signup');
    final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(request.toJson()));
    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception('회원가입 실패: ${res.statusCode} / ${res.body}');
    }
  }
}
