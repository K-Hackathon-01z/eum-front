import 'package:flutter/material.dart';
import 'package:eum_demo/services/user/career_test_service.dart';
import 'package:eum_demo/models/career_test/question.dart';

class CareerTestProvider extends ChangeNotifier {
  final CareerTestService _service;
  List<Question> _questions = [];
  bool _isLoading = false;
  String? _error;

  CareerTestProvider({CareerTestService? service}) : _service = service ?? CareerTestService();

  List<Question> get questions => _questions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchQuestions(int userId) async {
    _isLoading = true;
    _error = null;
    try {
      final data = await _service.fetchRecommendedSupports(userId);
      _questions = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
