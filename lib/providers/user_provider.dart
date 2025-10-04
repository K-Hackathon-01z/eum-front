import 'package:flutter/material.dart';
import '../services/user/user_service.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<dynamic> _users = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<dynamic> get users => _users;

  Future<void> fetchAllUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await UserService.fetchAllUsers();
      _users = result;
    } catch (e) {
      _error = e.toString();
      _users = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _users = [];
    notifyListeners();
  }
}
