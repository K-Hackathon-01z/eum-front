import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eum_demo/models/skill_list/skill_category.dart'; // SkillCategory 모델 임포트

class SkillService {
  final http.Client _client;

  SkillService({http.Client? client}) : _client = client ?? http.Client();

  // 전체 기술 카테고리 조회 (모델 파싱)
  Future<List<SkillCategory>> fetchAllSkillCategoriesParsed() async {
    final url = Uri.parse('http://3.26.220.20:8080/api/skill-category');
    try {
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return data.map((e) => SkillCategory.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      // 에러 처리 (로깅 등)
      return [];
    }
  }
}
