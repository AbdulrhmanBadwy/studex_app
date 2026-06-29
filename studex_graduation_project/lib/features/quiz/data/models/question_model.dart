import 'package:studex_graduation_project/features/quiz/domain/entites/question_entity.dart';



class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.question,
    required super.options,
    required super.correctOptionIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctAnswerIndex'],
    );
  }
  factory QuestionModel.fromEntity(QuestionEntity entity) {
    return QuestionModel(
      question: entity.question,
      options: entity.options,
      correctOptionIndex: entity.correctOptionIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswerIndex': correctOptionIndex,
    };
  }
}