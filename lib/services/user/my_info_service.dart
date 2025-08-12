// api.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class MyInfoService {
  static const base = 'https://eum-back.onrender.com';

  // 사용자 이메일로 정보 가져오기
  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final uri = Uri.parse(base).replace(pathSegments: ['api', 'user', email]);
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('조회 실패: ${res.statusCode}');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
