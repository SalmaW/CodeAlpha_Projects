class Question {
  final int id;
  final String questions;
  final String category;
  final List<String> options;
  final int answer;

  const Question({
    required this.id,
    required this.questions,
    required this.category,
    required this.options,
    required this.answer,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "questions": questions,
        "category": category,
        "options": options,
        "answer": answer,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questions: json["questions"],
        category: json["category"],
        options: List<String>.from(json['options']),
        answer: json["answer"],
      );
}
