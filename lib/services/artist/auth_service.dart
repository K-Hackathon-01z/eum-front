import 'dart:convert';
import 'dart:io'; // 추가
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eum_demo/models/artist/signup_request.dart';
import 'package:eum_demo/models/artist/artist.dart';

class ArtistAuthService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  // 추가: 장인 이미지 업로드
  Future<String> uploadArtisanImage(File file) async {
    final uri = Uri.parse('$base/api/images/upload/artisan');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // 서버가 URL을 따옴표로 감싸서 보낼 경우를 대비해 제거
      return responseBody.replaceAll('"', '');
    } else {
      throw Exception('이미지 업로드 실패: ${response.statusCode}');
    }
  }

  Future<bool> signup(ArtistSignupRequest req) async {
    final url = Uri.parse('$base/api/artisans');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }

  Future<Artist> getByEmail(String email) async {
    final url = Uri.parse('$base/api/artisans/email/$email');
    final res = await http.get(url, headers: {'accept': '*/*'});
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      return Artist.fromJson(map);
    }
    throw Exception('장인 정보 조회 실패: ${res.statusCode} / ${res.body}');
  }
}
