import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/models/quiz_model.dart';

void main() {
  test('QuizModel toJson/fromJson and copyWith', () {
    final quiz = QuizModel(id: 'q1', title: 'Quiz', description: 'd', timePerQuestion: 30, creatorId: 'u1');
    final json = quiz.toJson();
    final restored = QuizModel.fromJson(json);
    expect(restored, equals(quiz));

    final modified = quiz.copyWith(title: 'New Quiz');
    expect(modified.title, 'New Quiz');
  });
}
