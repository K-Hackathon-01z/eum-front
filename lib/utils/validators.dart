class Validators {
  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return '이름을 입력해주세요.';
    }
    // 추가 검증 로직(예: 특수문자, 길이 제한 등) 필요시 여기에 작성
    return null;
  }

  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return '이메일을 입력해주세요.';
    }
    // 이메일 형식 정규식
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return '올바른 이메일 형식을 입력해주세요.';
    }
    return null;
  }
}
