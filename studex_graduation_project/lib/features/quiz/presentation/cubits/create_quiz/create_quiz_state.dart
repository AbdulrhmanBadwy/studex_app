abstract class CreateQuizState {}

class CreateQuizInitial extends CreateQuizState {}

class CreateQuizLoading extends CreateQuizState {}

class CreateQuizSuccess extends CreateQuizState {}

class CreateQuizError extends CreateQuizState {
  final String message;
  CreateQuizError(this.message);
}