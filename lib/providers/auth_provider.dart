import 'package:flutter/material.dart';
import '../models/user/user_signup_request.dart';
import '../services/user/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _emailRequested = false;
  bool _emailConfirmed = false;

  bool get emailRequested => _emailRequested;
  bool get emailConfirmed => _emailConfirmed;

  Future<void> requestEmailCode(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await _service.requestEmailCode(email);
      _emailRequested = result;
      if (!result) _error = '이메일 인증코드 요청에 실패했습니다.';
    } catch (e) {
      _error = e.toString();
      _emailRequested = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> confirmEmailCode(String email, String code) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await _service.confirmEmailCode(email, code);
      _emailConfirmed = result;
      if (!result) _error = '인증코드 확인에 실패했습니다.';
    } catch (e) {
      _error = e.toString();
      _emailConfirmed = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetEmailAuth() {
    _emailRequested = false;
    _emailConfirmed = false;
    notifyListeners();
  }

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
      // 회원가입 성공 시 이메일 저장
      if (_success && _email != null && _email!.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', _email!);
      }
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
