import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/repositres/quiz_repository.dart';

class SubmitQuizAnswers {
  final QuizRepository repo;
  SubmitQuizAnswers(this.repo);

  Future<void> call(
    String roomId,
    QuizEntity quiz,
    String userId,
    List<int> userAnswers,
  ) async {
    int score = 0;
    for (int i = 0; i < quiz.questions.length; i++) {
      if (quiz.questions[i].correctOptionIndex == userAnswers[i]) {
        score++;
      }
    }

    await repo.submitQuizAnswers(roomId, quiz.id, userId, userAnswers, score);
  }
}
