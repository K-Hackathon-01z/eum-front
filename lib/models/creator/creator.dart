class Creator {
  String get subCategory {
    switch (skillId) {
      case 1:
        return "금속공예";
      case 2:
        return "나전 칠기";
      case 3:
        return "도자기";
      case 4:
        return "매듭장";
      case 5:
        return "칠장";
      case 6:
        return "한지";
      case 7:
        return "홍염장";
      case 8:
        return "한복장";
      case 9:
        return "자수";
      case 10:
        return "매듭";
      case 11:
        return "전통주";
      case 12:
        return "장";
      case 13:
        return "다과";
      case 14:
        return "판소리";
      case 15:
        return "민요";
      case 16:
        return "탈춤";
      case 17:
        return "무용";
      case 18:
        return "단청장";
      case 19:
        return "소목장";
      default:
        return "기타";
    }
  }

  final int id;
  final int skillId;
  final String name;
  final String photoUrl;
  final String mainWorks;
  final String biography;
  final String email;

  Creator({
    required this.id,
    required this.skillId,
    required this.name,
    required this.photoUrl,
    required this.mainWorks,
    required this.biography,
    required this.email,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'],
      skillId: json['skillId'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      mainWorks: json['mainWorks'],
      biography: json['biography'],
      email: json['email'],
    );
  }
}
