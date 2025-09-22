import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user/user_signup_request.dart';

class UserService {
  static const base = 'http://3.26.220.20:8080';

  Future<bool> signup(UserSignupRequest request) async {
    final url = Uri.parse('$base/api/user/signup');
    final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(request.toJson()));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('회원가입 실패: ${res.statusCode} / ${res.body}');
    }
  }
}
