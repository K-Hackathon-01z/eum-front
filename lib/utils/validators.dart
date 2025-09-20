class Validators {
  static String? validateGender(String? gender) {
    if (gender == null || gender.trim().isEmpty) {
      return '성별을 선택해주세요.';
    }
    return null;
  }

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

  static String? validateAge(String age) {
    if (age.trim().isEmpty) {
      return '나이를 입력해주세요.';
    }
    final num? ageNum = num.tryParse(age.trim());
    if (ageNum == null || ageNum < 0 || ageNum > 120) {
      return '나이는 0~120 사이의 숫자입니다.';
    }
    return null;
  }
}
