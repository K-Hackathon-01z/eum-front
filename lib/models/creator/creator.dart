class Creator {
  final int skillId;
  final String name;
  final String photoUrl;
  final String mainWorks;
  final String biography;
  final String email;

  Creator({
    required this.skillId,
    required this.name,
    required this.photoUrl,
    required this.mainWorks,
    required this.biography,
    required this.email,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      skillId: json['skillId'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      mainWorks: json['mainWorks'],
      biography: json['biography'],
      email: json['email'],
    );
  }
}
