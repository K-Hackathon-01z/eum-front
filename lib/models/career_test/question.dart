class Question {
  final int id;
  final String questionText;
  final List<Option> options;

  // 생성자
  Question({
    required this.id,
    required this.questionText,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['text'],
      options: (json['options'] as List)
          .map((opt) => Option.fromJson(opt))
          .toList(),
    );
  }
}

// 어차피 딸려오는거라 그냥 분리 안함
class Option {
  final int id;
  final String text;

  // 생성자
  Option({required this.id, required this.text});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(id: json['id'], text: json['text']);
  }
}
