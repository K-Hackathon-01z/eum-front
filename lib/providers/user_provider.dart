import 'package:flutter/material.dart';
import '../models/user/user_signup_request.dart';
import '../services/user/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();

  bool _isLoading = false;
  String? _error;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get success => _success;

  Future<void> signup(UserSignupRequest request) async {
    _isLoading = true;
    _error = null;
    _success = false;
    notifyListeners();
    try {
      final result = await _service.signup(request);
      _success = result;
    } catch (e) {
      _error = e.toString();
      _success = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _success = false;
    notifyListeners();
  }
}
