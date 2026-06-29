import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_result_entity.dart';

abstract class QuizRepository {
  Stream<List<QuizEntity>> getQuizzes(String roomId);
  Future<void> createQuiz(QuizEntity quiz, String roomId);
  Future<QuizEntity?> getQuizById(String roomId, String quizId);
  Future<void> submitQuizAnswers(
    String roomId,
    String quizId,
    String userId,
    List<int> answers,
    int score,
  );
  Future<QuizResultEntity?> getQuizResult(
    String roomId,
    String quizId,
    String userId,
  );
}
