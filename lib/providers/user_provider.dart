import 'package:flutter/material.dart';
import '../services/user/user_service.dart';
import '../models/user/user.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<dynamic> _users = [];
  User? _currentUser;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<dynamic> get users => _users;
  User? get currentUser => _currentUser;

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

  Future<void> fetchUserByEmail(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final userJson = await UserService.getUserByEmail(email);
      _currentUser = User.fromJson(userJson);
    } catch (e) {
      _error = e.toString();
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _users = [];
    _currentUser = null;
    notifyListeners();
  }
}
