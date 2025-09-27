// api.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyInfoService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  // 사용자 이메일로 정보 가져오기
  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final uri = Uri.parse(base).replace(pathSegments: ['api', 'user', email]);
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('조회 실패: ${res.statusCode}');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
