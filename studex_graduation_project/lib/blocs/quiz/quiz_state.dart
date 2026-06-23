import 'package:equatable/equatable.dart';
import '../../models/quiz_model.dart';
import '../../models/question_model.dart';

sealed class QuizState extends Equatable {
  const QuizState();
}

class QuizInitial extends QuizState {
  const QuizInitial();
  @override
  List<Object?> get props => [];
}

class QuizLoading extends QuizState {
  const QuizLoading();
  @override
  List<Object?> get props => [];
}

class QuizzesLoaded extends QuizState {
  final List<QuizModel> quizzes;

  const QuizzesLoaded({required this.quizzes});

  @override
  List<Object?> get props => [quizzes];
}

class QuizCreated extends QuizState {
  const QuizCreated();
  @override
  List<Object?> get props => [];
}

class QuizTakingState extends QuizState {
  final QuizModel quiz;
  final List<QuestionModel> questions;
  final Map<int, int> answers; // questionIndex -> selectedOptionIndex

  const QuizTakingState({
    required this.quiz,
    required this.questions,
    this.answers = const {},
  });

  QuizTakingState copyWithAnswer(int questionIndex, int optionIndex) {
    return QuizTakingState(
      quiz: quiz,
      questions: questions,
      answers: {...answers, questionIndex: optionIndex},
    );
  }

  bool get allAnswered => answers.length == questions.length;

  @override
  List<Object?> get props => [quiz, questions, answers];
}

class QuizResultState extends QuizState {
  final int score;
  final int totalQuestions;
  final int totalMarks;

  const QuizResultState({
    required this.score,
    required this.totalQuestions,
    required this.totalMarks,
  });

  double get percentage => totalMarks > 0 ? (score / totalMarks) * 100 : 0;

  @override
  List<Object?> get props => [score, totalQuestions, totalMarks];
}

class QuizFailure extends QuizState {
  final String message;

  const QuizFailure({required this.message});

  @override
  List<Object?> get props => [message];
}