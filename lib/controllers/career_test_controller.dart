import 'package:flutter/cupertino.dart';

import '../models/career_test/question.dart';

class TestController extends ChangeNotifier {
  List<Question> _questions = []; // 질문 리스트
  int _currentIndex = 0; // 현재 보고 있는 질문 번호
  Map<int, int> _answers = {}; // [질문 번호]: [선택지 인덱스]

  // getter로 외부에서 읽기만 하게
  Question get currentQuestion => _questions[_currentIndex];
  int? get selectedIndex => _answers[_currentIndex];

  bool get isLast => _currentIndex == _questions.length - 1;

  // Future<void> loadQuestions() async {
  //   _questions = await fetchQuestions();
  //   notifyListeners(); // 화면 새로 그림
  // }

  void selectOption(int index) {
    _answers[_currentIndex] = index;
    notifyListeners();
  }

  void goToNext() {
    if (!isLast) {
      _currentIndex++;
      notifyListeners();
    }
  }

  Future<void> submit() async {
    await submitToApi(_answers);
  }

  Future<void> submitToApi(Map<int, int> answers) async {}
}
