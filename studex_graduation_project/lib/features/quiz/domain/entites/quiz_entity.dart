import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/question_entity.dart';

class QuizEntity {
  final String id;
  final String title;
  final String description;
  final String roomId;
  final DateTime? createdAt;
  final int resultsCount;
  final List<QuestionEntity> questions;
  QuizEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.roomId,
    this.createdAt,
    this.resultsCount = 0,
    required this.questions,
  });

  static DateTime? parseCreatedAt(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    return null;
  }
}
