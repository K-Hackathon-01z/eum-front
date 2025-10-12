class OnedayClass {
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
