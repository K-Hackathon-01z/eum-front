import 'dart:convert';

import 'package:eum_demo/screens/user/career/career_test_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 동적 위젯
class CareerTestScreen extends StatefulWidget {
  @override
  State<CareerTestScreen> createState() => _CareerTestScreenState();
}

class _CareerTestScreenState extends State<CareerTestScreen> {
  // ★ 빌드 밖 상태들
  late Future<List<Map<String, dynamic>>> future; // [ {questionId, text, options:[{optionId,text}...]}, ... ]
  int current = 0;
  List<int?> answers = []; // 선택 "인덱스" 저장 (0-based)

  @override
  void initState() {
    super.initState();
    future = fetchQuestions(); // 최초 로드
  }

  // ★ 1) 질문 목록 가져오기
  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    final url = Uri.parse('https://eum-back.onrender.com/api/matching/careerTest');
    final res = await http.get(url, headers: {'accept': '*/*'});
    if (res.statusCode != 200) {
      throw Exception('질문 조회 실패: ${res.statusCode}');
    }
    final body = jsonDecode(res.body);
    // ▶ 서버 응답이 최상위 "배열"임 (List<dynamic>)
    final items = (body as List).map((e) => Map<String, dynamic>.from(e as Map)).toList();

    answers = List<int?>.filled(items.length, null);
    return items;
  }

  // ★ 2) 제출 (백엔드가 index만 받는다면 selectedIndex만 전송하면 됨)
  //    안전하게 optionId도 함께 넣어줌(백엔드가 더 좋아할 가능성↑).
  Future<List<dynamic>> submitAnswers(List<Map<String, dynamic>> questions, int userid) async {
    final payload = {
      "optionIds": List.generate(questions.length, (i) {
        final q = questions[i];
        final sel = answers[i]!;
        final opts = (q['options'] as List).map((e) => Map<String, dynamic>.from(e)).toList();
        final selectedOption = opts[sel];
        return selectedOption['optionId'];
      }),
    };

    // TODO: 실제 제출 URL
    final url = Uri.parse('https://eum-back.onrender.com/api/matching/submit/$userid');
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

  double _progress(int total) => total == 0 ? 0 : (current + 1) / total;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snap.hasError) {
          return Scaffold(
            appBar: _appBar(),
            body: Center(child: Text('에러: ${snap.error}')),
          );
        }

        final questions = snap.data!;
        final q = questions[current];
        // ★ options는 객체 리스트 → 텍스트만 뽑아서 표시
        final optionMaps = (q['options'] as List).map((e) => Map<String, dynamic>.from(e)).toList();
        final optionTexts = optionMaps.map((m) => m['text'].toString()).toList();

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
                // ★ 질문 텍스트 키: text
                Text(
                  q['text'].toString(),
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

                // ★ 선택지
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

                // ★ 다음/제출 버튼
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
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
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
  );
}
