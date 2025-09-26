import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/career_test/question.dart';

class CareerTestService {
  static const base = 'http://3.26.220.20:8080';

  Future<List<Question>> fetchRecommendedSupports(int userId) async {
    final response = await http.get(Uri.parse('$base/api/matching/careerTest'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // 실제 모델에 맞게 파싱 필요
      return data.map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load recommended supports');
    }
  }
}
