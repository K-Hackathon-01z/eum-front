class BenefitInfo {
  final String title;
  final String description;
  final String category;
  final String targetAge;
  final String url;

  BenefitInfo({
    required this.title,
    required this.description,
    required this.category,
    required this.targetAge,
    required this.url,
  });

  factory BenefitInfo.fromJson(Map<String, dynamic> json) {
    return BenefitInfo(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      targetAge: json['targetAge'] as String,
      url: json['url'] as String,
    );
  }
}
