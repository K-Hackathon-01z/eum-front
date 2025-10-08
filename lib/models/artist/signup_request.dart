class ArtistSignupRequest {
  final int skillId;
  final String email;
  final String name;
  final String photoUrl;
  final String mainWorks;
  final String biography;

  ArtistSignupRequest({
    required this.skillId,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.mainWorks,
    required this.biography,
  });

  Map<String, dynamic> toJson() => {
    'skillId': skillId,
    'email': email,
    'name': name,
    'photoUrl': photoUrl,
    'mainWorks': mainWorks,
    'biography': biography,
  };
}
