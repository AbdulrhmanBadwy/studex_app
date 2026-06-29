

abstract class SubmitQuizState {}

class SubmitQuizInitial extends SubmitQuizState {}

class SubmitQuizLoading extends SubmitQuizState {}

class SubmitQuizSuccess extends SubmitQuizState {
  final int score;
  final int totalQuestions;
  SubmitQuizSuccess({required this.score, required this.totalQuestions});
}

class SubmitQuizError extends SubmitQuizState {
  final String message;
  SubmitQuizError(this.message);
}