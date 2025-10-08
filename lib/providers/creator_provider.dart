import 'package:flutter/material.dart';
import '../models/creator/creator.dart';
import '../services/creator/creator_service.dart';

class CreatorProvider extends ChangeNotifier {
  List<Creator> _creators = [];
  bool _isLoading = false;
  String? _error;

  Creator? _creatorByEmail;
  bool _isEmailLoading = false;
  String? _emailError;

  final CreatorService _service = CreatorService();

  List<Creator> get creators => _creators;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Creator? get creatorByEmail => _creatorByEmail;
  bool get isEmailLoading => _isEmailLoading;
  String? get emailError => _emailError;

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

  Future<void> fetchCreatorByEmail(String email) async {
    _isEmailLoading = true;
    _emailError = null;
    notifyListeners();
    try {
      final creator = await _service.fetchCreatorByEmail(email);
      _creatorByEmail = creator;
    } catch (e) {
      _emailError = e.toString();
      _creatorByEmail = null;
    } finally {
      _isEmailLoading = false;
      notifyListeners();
    }
  }
}
