class Validators {
  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return '이름을 입력해주세요.';
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return '이메일을 입력해주세요.';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return '올바른 이메일 형식을 입력해주세요.';
    }
    return null;
  }

  static String? validateAuthCode(String code) {
    if (code.trim().length < 6) {
      return '유효한 인증코드가 아닙니다.';
    }
    return null;
  }
}
