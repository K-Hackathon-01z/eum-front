import 'dart:convert';
import 'package:http/http.dart' as http;

class SkillService {
  final http.Client _client;

  SkillService({http.Client? client}) : _client = client ?? http.Client();

  // 예시: 카테고리별 스킬 리스트 가져오기
  Future<List<String>> fetchSkillsByCategory(String category) async {
    // 실제 API 엔드포인트로 교체 필요
    final url = Uri.parse('https://your-api-domain.com/api/skills?category=$category');
    try {
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // 예시: { "skills": ["금속", "도자기", ...] }
        if (data is Map && data['skills'] is List) {
          return List<String>.from(data['skills']);
        }
      }
      return [];
    } catch (e) {
      // 에러 처리 (로깅 등)
      return [];
    }
  }

  // 전체 기술 카테고리 조회
  Future<List<dynamic>> fetchAllSkillCategories() async {
    final url = Uri.parse('https://eum-back.onrender.com/api/skill-category');
    try {
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // data가 리스트 형태라면 바로 반환, 아니면 가공 필요
        return data is List ? data : [];
      }
      return [];
    } catch (e) {
      // 에러 처리 (로깅 등)
      return [];
    }
  }
}
