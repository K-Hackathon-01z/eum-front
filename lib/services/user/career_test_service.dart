import 'dart:convert';

import '../../models/career_test/question.dart';

Future<List<Question>> fetchQuestions() async {
  var http;
  final response = await http.get(
    Uri.parse('https://eum-back.onrender.com/api/matching/careerTest'),
  );

  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    return data.map((e) => Question.fromJson(e)).toList();
  } else {
    // 응답 실패시 예외 던지기
    throw Exception('Failed to load survey');
  }
}
