import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';

abstract class GetQuizzesState {}

class GetQuizzesInitial extends GetQuizzesState {}

class GetQuizzesLoading extends GetQuizzesState {}

class GetQuizzesLoaded extends GetQuizzesState {
  final List<QuizEntity> quizzes;
  GetQuizzesLoaded(this.quizzes);
}

class GetQuizzesError extends GetQuizzesState {
  final String message;
  GetQuizzesError(this.message);
}
