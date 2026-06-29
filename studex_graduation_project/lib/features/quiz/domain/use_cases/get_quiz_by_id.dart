import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/repositres/quiz_repository.dart';

class GetQuizById {
  final QuizRepository repo;
  GetQuizById(this.repo);

  Future<QuizEntity?> call(String roomId, String quizId) async {
    return await repo.getQuizById(roomId, quizId);
  }
}