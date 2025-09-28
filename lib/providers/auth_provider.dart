import 'package:flutter/material.dart';
import '../models/user/user_signup_request.dart';
import '../services/user/auth_service.dart';
import '../services/user/user_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _emailRequested = false;
  bool _emailConfirmed = false;

  bool get emailRequested => _emailRequested;
  bool get emailConfirmed => _emailConfirmed;

  final AuthService _authService = AuthService();

  Future<void> requestEmailCode(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await _authService.requestEmailCode(email);
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
      final result = await _authService.confirmEmailCode(email, code);
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
      final result = await _authService.signup(request);
      _success = result;
      if (result) {
        // 회원가입 성공 시 사용자 정보 조회 및 세팅
        try {
          final userData = await UserService.getUserByEmail(request.email);
          _email = userData['email'];
          _name = userData['name'];
          _age = userData['age'] is int ? userData['age'] : int.tryParse(userData['age'].toString());
          _address = userData['address'];
          _gender = userData['gender'];
        } catch (e) {
          // 사용자 정보 조회 실패 시 무시 (에러는 _error에 남기지 않음)
        }
      }
    } catch (e) {
      _error = e.toString();
      _success = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email) async {
    _isLoading = true;
    _error = null;
    _success = false;
    notifyListeners();
    try {
      // 실제 서비스에서는 사용자 정보 조회 API 호출 필요
      final userData = await UserService.getUserByEmail(email);
      if (userData['email'] == email) {
        _email = userData['email'];
        _name = userData['name'];
        _age = userData['age'] is int ? userData['age'] : int.tryParse(userData['age'].toString());
        _address = userData['address'];
        _gender = userData['gender'];
        _success = true;
      } else {
        _success = false;
        _error = '이메일이 비어있습니다.';
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
