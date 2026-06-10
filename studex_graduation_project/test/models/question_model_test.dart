import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/models/question_model.dart';

void main() {
  test('QuestionModel toJson/fromJson and copyWith', () {
    final q = QuestionModel(id: 'q1', text: 'What?', options: ['A','B','C'], correctOptionIndex: 0, marks: 2);
    final json = q.toJson();
    final restored = QuestionModel.fromJson(json);
    expect(restored, equals(q));

    final modified = q.copyWith(text: 'Who?');
    expect(modified.text, 'Who?');
  });
}
