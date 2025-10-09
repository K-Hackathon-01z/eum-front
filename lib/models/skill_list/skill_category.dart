class SkillCategory {
  final int id;
  final String name;
  final String category;
  final String description;
  final String? image_url;
  final String? careerPath;

  SkillCategory({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.image_url,
    this.careerPath,
  });

  factory SkillCategory.fromJson(Map<String, dynamic> json) {
    return SkillCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      image_url: json['image_url'] as String?,
      careerPath: json['career_path'] as String?,
    );
  }
}
