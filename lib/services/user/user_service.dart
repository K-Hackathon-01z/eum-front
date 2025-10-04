import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class UserService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  static Future<List<dynamic>> fetchAllUsers() async {
    final url = Uri.parse('$base/api/user/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('전체 회원 조회 실패');
    }
  }

  // 사용자 이메일로 회원 삭제
  static Future<bool> deleteUserByEmail(String email) async {
    final uri = Uri.parse(base).replace(pathSegments: ['api', 'user', email]);
    final res = await http.delete(uri);
    return res.statusCode == 200;
  }

  // 사용자 이메일로 정보 가져오기
  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final uri = Uri.parse(base).replace(pathSegments: ['api', 'user', email]);
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('조회 실패: ${res.statusCode}');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
