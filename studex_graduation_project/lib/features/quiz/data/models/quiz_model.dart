import 'package:studex_graduation_project/features/quiz/data/models/question_model.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.id,
    required super.title,
    required super.description,
    required super.roomId,
    super.createdAt,
    super.resultsCount,

    required List<QuestionModel> questions,
  }) : super(questions: questions);

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      roomId: json['roomId'] as String? ?? '',
      createdAt: QuizEntity.parseCreatedAt(json['createdAt']),
      resultsCount: (json['resultsCount'] as num?)?.toInt() ?? 0,

      questions: (json['questions'] as List<dynamic>? ?? const [])
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }
  factory QuizModel.fromEntity(QuizEntity entity) {
    return QuizModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      roomId: entity.roomId,
      createdAt: entity.createdAt,
      resultsCount: entity.resultsCount,
      questions: entity.questions
          .map((q) => QuestionModel.fromEntity(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'roomId': roomId,
      'createdAt': createdAt,
      'resultsCount': resultsCount,

      'questions': questions.map((e) => (e as QuestionModel).toJson()).toList(),
    };
  }
}
