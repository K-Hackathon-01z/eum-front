class OnedayClass {
  String get subCategory {
    switch (skillId) {
      case 1:
        return '금속 공예';
      case 2:
        return '나전칠기';
      case 3:
        return '도자기';
      case 4:
        return '매듭장';
      case 5:
        return '칠장';
      case 6:
        return '한지';
      case 7:
        return '홍염장';
      case 8:
        return '한복장';
      case 9:
        return '자수';
      case 10:
        return '매듭';
      case 11:
        return '전통주';
      case 12:
        return '장';
      case 13:
        return '다과';
      case 14:
        return '판소리';
      case 15:
        return '민요';
      case 16:
        return '탈춤';
      case 17:
        return '무용';
      case 18:
        return '단청장';
      case 19:
        return '소목장';
      default:
        return '기타';
    }
  }

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

  OnedayClass({
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

  factory OnedayClass.fromJson(Map<String, dynamic> json) {
    return OnedayClass(
      id: json['id'] ?? 0,
      skillId: json['skillId'] ?? 0,
      artisanId: json['artisanId'] ?? 0,
      title: json['title'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      capacity: json['capacity'] ?? 0,
      interestedCount: json['interestedCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skillId': skillId,
      'artisanId': artisanId,
      'title': title,
      'photoUrl': photoUrl,
      'description': description,
      'price': price,
      'location': location,
      'capacity': capacity,
      'interestedCount': interestedCount,
    };
  }
}
