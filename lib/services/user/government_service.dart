import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/government/benefit_info.dart';

class GovernmentService {
  final http.Client _client;
  GovernmentService({http.Client? client}) : _client = client ?? http.Client();

  // 정부 혜택 추천 API: GET /api/supports/recommend/{userId}
  Future<List<BenefitInfo>> fetchRecommendedBenefits(String userId) async {
    final url = Uri.parse('http://3.26.220.20:8080/api/supports/recommend/$userId');
    try {
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return data.map((e) => BenefitInfo.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      // 에러 처리 (로깅 등)
      return [];
    }
  }
}
