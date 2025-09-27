import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class UserService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<dynamic>> fetchAllUsers() async {
    final url = Uri.parse('$base/api/user/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('전체 회원 조회 실패');
    }
  }
}
