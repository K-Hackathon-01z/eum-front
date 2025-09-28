import 'package:flutter/material.dart';
import 'package:eum_demo/services/user/government_service.dart';
import 'package:eum_demo/models/government/benefit_info.dart';

class GovernmentProvider extends ChangeNotifier {
  final GovernmentService _service;
  List<BenefitInfo> _benefits = [];
  bool _isLoading = false;
  String? _error;

  GovernmentProvider({GovernmentService? service}) : _service = service ?? GovernmentService();

  List<BenefitInfo> get benefits => _benefits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRecommendedBenefits(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _service.fetchRecommendedBenefits(userId);
      _benefits = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
