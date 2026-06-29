import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_result_entity.dart';

class QuizResultModel extends QuizResultEntity {
  const QuizResultModel({
    required super.userId,
    required super.quizId,
    required super.score,
    required super.totalQuestions,
    required super.answers,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      userId: json['userId'],
      quizId: json['quizId'],
      score: json['score'],
      totalQuestions: json['totalQuestions'],
      answers: List<int>.from(json['answers']),
    );
  }

  factory QuizResultModel.fromEntity(QuizResultEntity entity) {
    return QuizResultModel(
      userId: entity.userId,
      quizId: entity.quizId,
      score: entity.score,
      totalQuestions: entity.totalQuestions,
      answers: entity.answers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'answers': answers,
    };
  }
}