import 'package:studex_graduation_project/features/quiz/data/models/question_model.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.id,
    required super.title,
    required super.description,

    required List<QuestionModel> questions,
  }) : super(questions: questions);

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],

      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }
  factory QuizModel.fromEntity(QuizEntity entity) {
    return QuizModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
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

      'questions': questions.map((e) => (e as QuestionModel).toJson()).toList(),
    };
  }
}
