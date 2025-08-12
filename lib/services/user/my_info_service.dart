// api.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const base = 'https://eum-back.onrender.com';

  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final uri = Uri.parse('$base/api/user/${Uri.encodeComponent(email)}');
    final res = await http.get(uri);
    Uri.parse('$base/api/user/${Uri.encodeComponent(email)}');
    if (res.statusCode != 200) throw Exception('조회 실패: ${res.statusCode}');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
