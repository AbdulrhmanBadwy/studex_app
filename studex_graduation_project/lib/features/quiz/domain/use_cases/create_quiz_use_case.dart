import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/repositres/quiz_repository.dart';

class CreateQuizUseCase {
  final QuizRepository repo;
  CreateQuizUseCase(this.repo);
  Future<void> call(QuizEntity quiz, String roomId) async {
    if (quiz.title.isEmpty) {
      throw Exception("Title is required");
    }

    if (quiz.questions.isEmpty) {
      throw Exception("Quiz must contain at least one question");
    }

    await repo.createQuiz(quiz, roomId);
  }
}