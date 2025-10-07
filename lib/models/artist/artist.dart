class Artist {
  final int id;
  final int skillId;
  final String email;
  final String name;
  final String photoUrl;
  final String mainWorks;
  final String biography;

  Artist({
    required this.id,
    required this.skillId,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.mainWorks,
    required this.biography,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
    skillId: json['skillId'] is int
        ? json['skillId']
        : int.tryParse('${json['skillId']}') ?? 1,
    email: '${json['email'] ?? ''}',
    name: '${json['name'] ?? ''}',
    photoUrl: '${json['photoUrl'] ?? json['photourl'] ?? ''}',
    mainWorks: '${json['mainWorks'] ?? ''}',
    biography: '${json['biography'] ?? ''}',
  );
}
