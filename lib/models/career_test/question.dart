class Question {
  final String id;
  final String title;
  final List<Option> options;

  Question({required this.id, required this.title, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      options: (json['options'] as List)
          .map((opt) => Option.fromJson(opt))
          .toList(),
    );
  }
}

class Option {
  final String id;
  final String text;

  Option({required this.id, required this.text});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(id: json['id'], text: json['text']);
  }
}
