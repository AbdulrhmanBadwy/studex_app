import 'package:studex_graduation_project/features/quiz/data/data_source/quiz_remote_data_source.dart';
import 'package:studex_graduation_project/features/quiz/data/models/quiz_model.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_result_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/repositres/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;
  QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createQuiz(QuizEntity quiz, String roomId) async {
    final quizModel = QuizModel.fromEntity(quiz);
    await remoteDataSource.createQuiz(quizModel, roomId);
  }

  @override
  Stream<List<QuizEntity>> getQuizzes(String roomId) {
    return remoteDataSource.getQuizzes(roomId).map((quizModels) {
      return quizModels.map((quizModel) => quizModel as QuizEntity).toList();
    });
  }

  @override
  Future<QuizEntity?> getQuizById(String roomId, String quizId) {
    return remoteDataSource.getQuizById(roomId, quizId).then((quizModel) {
      return quizModel as QuizEntity?;
    });
  }

  @override
  Future<QuizResultEntity?> getQuizResult(
    String roomId,
    String quizId,
    String userId,
  ) {
    return remoteDataSource.getQuizResult(roomId, quizId, userId).then((
      quizResultModel,
    ) {
      return quizResultModel as QuizResultEntity?;
    });
  }

  @override
  Future<void> submitQuizAnswers(
    String roomId,
    String quizId,
    String userId,
    List<int> answers,
    int score,
  ) {
    return remoteDataSource.submitQuizAnswers(
      roomId,
      quizId,
      userId,
      answers,
      score,
    );
  }
}
