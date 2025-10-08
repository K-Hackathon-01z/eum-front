import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eum_demo/models/artist/class_request.dart';
import 'dart:io'; // 추가

class ClassService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  // 클래스 이미지 업로드 → URL 반환
  Future<String> uploadClassImage(File file) async {
    final uri = Uri.parse('$base/api/images/upload/class');
    final req = http.MultipartRequest('POST', uri);
    req.files.add(await http.MultipartFile.fromPath('file', file.path));
    final res = await req.send();
    final body = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      // 서버가 순수 문자열을 반환할 수 있어 따옴표 제거 처리
      final trimmed = body.trim();
      if (trimmed.length >= 2 &&
          trimmed.startsWith('"') &&
          trimmed.endsWith('"')) {
        return trimmed.substring(1, trimmed.length - 1);
      }
      return trimmed;
    }
    throw Exception('이미지 업로드 실패: ${res.statusCode} / $body');
  }

  Future<ArtistClassResponse> createClass(ArtistClassRequest req) async {
    final url = Uri.parse('$base/api/classes');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: jsonEncode(req.toJson()),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = res.body.isNotEmpty ? jsonDecode(res.body) : {};
      if (data is Map<String, dynamic>) {
        return ArtistClassResponse.fromJson(data);
      }
      // 바디가 없으면 요청값으로 응답 형태 구성
      return ArtistClassResponse(
        id: 0,
        skillId: req.skillId,
        artisanId: req.artisanId,
        title: req.title,
        photoUrl: req.photoUrl,
        description: req.description,
        price: req.price,
        location: req.location,
        capacity: req.capacity,
        interestedCount: 0,
      );
    }
    throw Exception('클래스 생성 실패: ${res.statusCode} / ${res.body}');
  }
}
