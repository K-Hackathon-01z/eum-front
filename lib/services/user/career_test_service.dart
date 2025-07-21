import 'dart:convert';

import '../../models/career_test/question.dart';

class TestService {
  Future<List<Question>> fetchQuestions(dynamic http) async {
    // 여기다가 api 쓰기
    final res = await http.get(Uri.parse('https://your.api/questions'));
    final data = jsonDecode(res.body) as List;
    return data.map((q) => Question.fromJson(q)).toList();
  }
}
