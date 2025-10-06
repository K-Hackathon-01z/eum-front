class Artisan {
  final int skillId;
  final String name;
  final String photoUrl;
  final String mainWorks;
  final String biography;
  final String email;

  Artisan({
    required this.skillId,
    required this.name,
    required this.photoUrl,
    required this.mainWorks,
    required this.biography,
    required this.email,
  });

  factory Artisan.fromJson(Map<String, dynamic> json) {
    return Artisan(
      skillId: json['skillId'] ?? 0,
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      mainWorks: json['mainWorks'] ?? '',
      biography: json['biography'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
