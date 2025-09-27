import 'package:flutter/material.dart';
import '../models/user/user_signup_request.dart';
import '../services/user/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  // 회원가입 단계별 입력값 저장
  String? _email;
  String? _name;
  int? _age;
  String? _address;
  String? _gender;

  String? get email => _email;
  String? get name => _name;
  int? get age => _age;
  String? get address => _address;
  String? get gender => _gender;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setAge(int value) {
    _age = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _address = value;
    notifyListeners();
  }

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  UserSignupRequest toSignupRequest() {
    return UserSignupRequest(
      email: _email ?? '',
      name: _name ?? '',
      age: _age ?? 0,
      address: _address ?? '',
      gender: _gender ?? '',
    );
  }

  final AuthService _service = AuthService();

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
    _email = null;
    _name = null;
    _age = null;
    _address = null;
    _gender = null;
    notifyListeners();
  }
}
