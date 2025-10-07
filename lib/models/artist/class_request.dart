class ArtistClassRequest {
  final int skillId; // 고정: 1
  final int artisanId; // 임시 고정: 1 (추후 실제 로그인 아티스트 id로 교체)
  final String title;
  final String photoUrl; 
  final String description;
  final int price;
  final String location;
  final int capacity;

  ArtistClassRequest({
    required this.skillId,
    required this.artisanId,
    required this.title,
    required this.photoUrl,
    required this.description,
    required this.price,
    required this.location,
    required this.capacity,
  });

  Map<String, dynamic> toJson() => {
    'skillId': skillId,
    'artisanId': artisanId,
    'title': title,
    'photourl': photoUrl, 
    'description': description,
    'price': price,
    'location': location,
    'capacity': capacity,
  };
}

class ArtistClassResponse {
  final int id;
  final int skillId;
  final int artisanId;
  final String title;
  final String photoUrl;
  final String description;
  final int price;
  final String location;
  final int capacity;
  final int interestedCount;

  ArtistClassResponse({
    required this.id,
    required this.skillId,
    required this.artisanId,
    required this.title,
    required this.photoUrl,
    required this.description,
    required this.price,
    required this.location,
    required this.capacity,
    required this.interestedCount,
  });

  factory ArtistClassResponse.fromJson(Map<String, dynamic> json) {
    return ArtistClassResponse(
      id: json['id'] ?? 0,
      skillId: json['skillId'] ?? 0,
      artisanId: json['artisanId'] ?? 0,
      title: json['title'] ?? '',
      photoUrl: (json['photoUrl'] ?? json['photourl'] ?? '').toString(),
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      capacity: json['capacity'] ?? 0,
      interestedCount: json['interestedCount'] ?? 0,
    );
  }
}
