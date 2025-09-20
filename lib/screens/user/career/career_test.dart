import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eum_demo/screens/user/career/career_test_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eum_demo/providers/career_test_provider.dart';
import 'package:eum_demo/models/career_test/question.dart';

// 동적 위젯
class CareerTestScreen extends StatefulWidget {
  @override
  State<CareerTestScreen> createState() => _CareerTestScreenState();
}

class _CareerTestScreenState extends State<CareerTestScreen> {
  int current = 0;
  List<int?> answers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CareerTestProvider>(context, listen: false);
      provider.fetchQuestions(1).then((_) {
        setState(() {
          answers = List<int?>.filled(provider.questions.length, null);
        });
      });
    });
  }

  double _progress(int total) => total == 0 ? 0 : (current + 1) / total;

  Future<List<dynamic>> submitAnswers(List<Question> questions, int userid) async {
    final payload = {
      "optionIds": List.generate(questions.length, (i) {
        final q = questions[i];
        final sel = answers[i]!;
        return q.options[sel].id;
      }),
    };
    final url = Uri.parse('http://3.26.220.20:8080/api/matching/submit/$userid');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: jsonEncode(payload),
    );
    if (res.statusCode != 200) {
      throw Exception('제출 실패: ${res.statusCode} / ${res.body}');
    }
    return jsonDecode(res.body) as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CareerTestProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (provider.error != null) {
          return Scaffold(
            appBar: _appBar(),
            body: Center(child: Text('에러: ${provider.error}')),
          );
        }
        final questions = provider.questions;
        if (questions.isEmpty) {
          return Scaffold(
            appBar: _appBar(),
            body: const Center(child: Text('질문 데이터가 없습니다')),
          );
        }
        // answers 초기화는 initState에서만 수행
        final q = questions[current];
        final optionTexts = q.options.map((opt) => opt.text).toList();
        final selected = answers[current];
        final total = questions.length;
        final isLast = current == total - 1;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${(_progress(total) * 100).round()}% 진행중...",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  q.questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  '목표에 맞는 맞춤 추천을 제공해요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2.3,
                    children: List.generate(optionTexts.length, (index) {
                      final isSelected = selected == index;
                      return GestureDetector(
                        onTap: () => setState(() => answers[current] = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFB9A6E7) : const Color(0xFFF2EDFB),
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected ? Border.all(color: const Color(0xFF3B2D5B), width: 3) : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            optionTexts[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: isSelected ? const Color(0xFF3B2D5B) : const Color(0xFFB9A6E7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0, top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: current == 0 ? null : () => setState(() => current--),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF2F2F2),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: const Text(
                            '이전',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: selected == null
                              ? null
                              : () async {
                                  if (!isLast) {
                                    setState(() => current++);
                                  } else {
                                    final resultList = await submitAnswers(questions, 3);
                                    if (!mounted) return;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => CareerTestResultPage(resultList: resultList)),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF2F2F2),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: Text(
                            isLast ? "제출" : "다음으로",
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: const Text(
      "성향 검사",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(color: Colors.grey[300], height: 1.0),
    ),
  );
}
