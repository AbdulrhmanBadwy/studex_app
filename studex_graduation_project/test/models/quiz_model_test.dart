import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studex_graduation_project/features/quiz/data/models/question_model.dart';
import 'package:studex_graduation_project/features/quiz/data/models/quiz_model.dart'
    as feature_quiz;
import 'package:studex_graduation_project/models/quiz_model.dart';

void main() {
  test('QuizModel toJson/fromJson and copyWith', () {
    final quiz = QuizModel(
      id: 'q1',
      title: 'Quiz',
      description: 'd',
      timePerQuestion: 30,
      creatorId: 'u1',
    );
    final json = quiz.toJson();
    final restored = QuizModel.fromJson(json);
    expect(restored, equals(quiz));

    final modified = quiz.copyWith(title: 'New Quiz');
    expect(modified.title, 'New Quiz');
  });

  test('Feature quiz model parses optional metadata', () {
    final createdAt = Timestamp.fromDate(DateTime(2026, 1, 2, 3, 4));
    final model = feature_quiz.QuizModel.fromJson({
      'id': 'q1',
      'title': 'Quiz',
      'description': 'Desc',
      'roomId': 'r1',
      'createdAt': createdAt,
      'resultsCount': 2,
      'questions': [
        QuestionModel(
          question: 'Q1',
          options: const ['A', 'B'],
          correctOptionIndex: 0,
        ).toJson(),
      ],
    });

    expect(model.roomId, 'r1');
    expect(model.createdAt, createdAt.toDate());
    expect(model.resultsCount, 2);
    expect(model.questions, isNotEmpty);
  });
}
