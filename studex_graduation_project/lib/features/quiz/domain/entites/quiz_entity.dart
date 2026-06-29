import 'package:studex_graduation_project/features/quiz/domain/entites/question_entity.dart';

class QuizEntity {
  final String id;
  final String title;
  final String description;
  final List<QuestionEntity> questions;
  QuizEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}
