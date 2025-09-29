import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/career_test/question.dart';

class CareerTestService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  // 전체 질문, 선택지 조회
  Future<List<Question>> fetchCareerTestQuestions() async {
    final response = await http.get(Uri.parse('$base/api/matching/careerTest'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load career test questions');
    }
  }

  // 응답 제출 및 추천 기술 저장
  Future<List<dynamic>> submitAnswers(int userId, List<int> optionIds) async {
    final url = Uri.parse('$base/api/matching/submit/$userId');
    final payload = {"optionIds": optionIds};
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: jsonEncode(payload),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to submit answers');
    }
  }

  // 저장된 추천 기술 반환
  Future<List<dynamic>> fetchRecommendations(int userId) async {
    final response = await http.get(Uri.parse('$base/api/matching/recommendations/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  // 사용자 검사 이력 조회
  Future<List<dynamic>> fetchHistory(int userId) async {
    final response = await http.get(Uri.parse('$base/api/matching/history/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load history');
    }
  }
}
