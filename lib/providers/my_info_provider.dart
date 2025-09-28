import 'package:flutter/material.dart';
import 'package:eum_demo/services/user/user_service.dart';

class MyInfoProvider extends ChangeNotifier {
  Map<String, dynamic>? _userInfo;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get userInfo => _userInfo;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserInfo(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await UserService.getUserByEmail(email);
      _userInfo = data;
    } catch (e) {
      _error = e.toString();
      _userInfo = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
