import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/repositres/quiz_repository.dart';

class GetQuizzes {
  final QuizRepository repo;
  GetQuizzes(this.repo);

  Stream<List<QuizEntity>> call(String roomId) {
    return repo.getQuizzes(roomId);
  }
}
