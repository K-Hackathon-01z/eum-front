import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArtistService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  // PUT /api/artisans/{id}
  Future<void> updateProfile({
    required int id,
    required String mainWorks,
    required String biography,
  }) async {
    final url = Uri.parse('$base/api/artisans/$id');
    final res = await http.put(
      url,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: jsonEncode({
        'photoUrl': 'string', // 항상 'string'으로 전송
        'mainWorks': mainWorks,
        'biography': biography,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('프로필 수정 실패: ${res.statusCode} / ${res.body}');
    }
  }
}
