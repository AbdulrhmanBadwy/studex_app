
import 'package:equatable/equatable.dart';
import '../../models/quiz_model.dart';
import '../../models/question_model.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();
}


class LoadQuizzesRequested extends QuizEvent {
  const LoadQuizzesRequested();
  @override
  List<Object?> get props => [];
}

class CreateQuizRequested extends QuizEvent {
  final QuizModel quiz;
  final List<QuestionModel> questions;

  const CreateQuizRequested({required this.quiz, required this.questions});

  @override
  List<Object?> get props => [quiz, questions];
}

class LoadQuestionsRequested extends QuizEvent {
  final String quizId;

  const LoadQuestionsRequested({required this.quizId});

  @override
  List<Object?> get props => [quizId];
}

class AnswerSelected extends QuizEvent {
  final int questionIndex;
  final int selectedOptionIndex;

  const AnswerSelected({
    required this.questionIndex,
    required this.selectedOptionIndex,
  });

  @override
  List<Object?> get props => [questionIndex, selectedOptionIndex];
}

class QuizSubmitted extends QuizEvent {
  final String userId;

  const QuizSubmitted({required this.userId});

  @override
  List<Object?> get props => [userId];
}