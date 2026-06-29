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

  QuizModel copyWith({
    String? id,
    String? title,
    String? description,
    int? timePerQuestion,
    String? creatorId,
  }) {
    return QuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timePerQuestion: timePerQuestion ?? this.timePerQuestion,
      creatorId: creatorId ?? this.creatorId,
    );
  }

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          timePerQuestion == other.timePerQuestion &&
          creatorId == other.creatorId;

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ description.hashCode ^ timePerQuestion.hashCode ^ creatorId.hashCode;
}
