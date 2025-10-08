import 'package:flutter/material.dart';
import '../models/creator/creator.dart';
import '../services/creator/creator_service.dart';

class CreatorProvider extends ChangeNotifier {
  List<Creator> _creators = [];
  bool _isLoading = false;
  String? _error;

  final CreatorService _service = CreatorService();

  List<Creator> get creators => _creators;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAllCreators() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _service.fetchAllCreators();
      _creators = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
