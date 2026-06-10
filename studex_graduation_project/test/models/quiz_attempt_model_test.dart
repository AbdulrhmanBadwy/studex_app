import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/models/quiz_attempt_model.dart';

void main() {
  test('QuizAttemptModel toJson/fromJson and copyWith', () {
    final attempt = QuizAttemptModel(id: 'a1', quizId: 'q1', userId: 'u1', score: 10, totalCorrect: 10, totalQuestions: 10);
    final json = attempt.toJson();
    final restored = QuizAttemptModel.fromJson(json);
    expect(restored, equals(attempt));

    final modified = attempt.copyWith(score: 9);
    expect(modified.score, 9);
  });
}
