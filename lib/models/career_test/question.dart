class Question {
  final int questionId;
  final String text;
  final int orderNo;
  final List<Option> options;

  Question({required this.questionId, required this.text, required this.orderNo, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['questionId'] ?? 0,
      text: json['text'] ?? '',
      orderNo: json['orderNo'] ?? 0,
      options: (json['options'] as List).map((opt) => Option.fromJson(opt)).toList(),
    );
  }
}

class Option {
  final int optionId;
  final String text;
  final int orderNo;

  Option({required this.optionId, required this.text, required this.orderNo});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(optionId: json['optionId'] ?? 0, text: json['text'] ?? '', orderNo: json['orderNo'] ?? 0);
  }
}
