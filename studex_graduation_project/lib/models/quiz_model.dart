class QuizModel {
  final String id;
  final String title;
  final String description;
  final int timePerQuestion;
  final String creatorId;

  const QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timePerQuestion,
    required this.creatorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timePerQuestion': timePerQuestion,
      'creatorId': creatorId,
    };
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timePerQuestion: json['timePerQuestion'] as int? ?? 30,
      creatorId: json['creatorId'] as String? ?? '',
    );
  }
}
