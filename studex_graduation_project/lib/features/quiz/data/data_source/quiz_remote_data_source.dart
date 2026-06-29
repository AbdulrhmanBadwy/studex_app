import 'package:studex_graduation_project/features/quiz/data/models/quiz_model.dart';
import 'package:studex_graduation_project/features/quiz/data/models/quiz_result_model.dart';

abstract class QuizRemoteDataSource {
  Stream<List<QuizModel>> getQuizzes(String roomId);
  Future<void> createQuiz(QuizModel quiz, String roomId);
  Future<QuizModel?> getQuizById(String roomId, String quizId);

  Future<void> submitQuizAnswers(
    String roomId,
    String quizId,
    String userId,
    List<int> answers,
    int score,
  );
  Future<QuizResultModel?> getQuizResult(
    String roomId,
    String quizId,
    String userId,
  );
}
