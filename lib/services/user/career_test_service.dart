import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/career_test/question.dart';

class CareerTestService {
  static const base = 'https://eum-back.onrender.com';

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(
      Uri.parse(base).replace(pathSegments: ['api', 'matching', 'careerTest']),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Question.fromJson(e)).toList();
    } else {
      // 응답 실패시 예외 던지기
      throw Exception('Failed to load survey');
    }
  }
}
