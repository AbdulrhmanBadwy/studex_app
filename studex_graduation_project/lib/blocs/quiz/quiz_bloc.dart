import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/quiz_attempt_model.dart';
import '../../models/quiz_model.dart';
import '../../repositories/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  StreamSubscription<List<QuizModel>>? _quizzesSubscription;

  QuizBloc({required this.quizRepository}) : super(const QuizInitial()) {
    on<LoadQuizzesRequested>(_onLoadQuizzes);
    on<CreateQuizRequested>(_onCreateQuiz);
    on<LoadQuestionsRequested>(_onLoadQuestions);
    on<AnswerSelected>(_onAnswerSelected);
    on<QuizSubmitted>(_onQuizSubmitted);
  }

  Future<void> _onLoadQuizzes(
      LoadQuizzesRequested event,
      Emitter<QuizState> emit,
      ) async {
    emit(const QuizLoading());
    await _quizzesSubscription?.cancel();

    await emit.forEach(
      quizRepository.getQuizzes(),
      onData: (quizzes) => QuizzesLoaded(quizzes: quizzes),
      onError: (e, _) => QuizFailure(message: e.toString()),
    );
  }

  Future<void> _onCreateQuiz(
      CreateQuizRequested event,
      Emitter<QuizState> emit,
      ) async {
    emit(const QuizLoading());
    try {
      if (event.questions.isEmpty) {
        emit(const QuizFailure(message: 'أضف سؤالاً واحداً على الأقل'));
        return;
      }

      for (int i = 0; i < event.questions.length; i++) {
        final q = event.questions[i];
        if (q.correctOptionIndex < 0 || q.correctOptionIndex >= q.options.length) {
          emit(QuizFailure(message: 'السؤال ${i + 1} لم يتم تحديد إجابة صحيحة'));
          return;
        }
      }

      await quizRepository.createQuiz(event.quiz, event.questions);
      emit(const QuizCreated());
    } catch (e) {
      emit(QuizFailure(message: e.toString()));
    }
  }

  Future<void> _onLoadQuestions(
      LoadQuestionsRequested event,
      Emitter<QuizState> emit,
      ) async {
    emit(const QuizLoading());
    try {
      final quiz = await quizRepository.getQuizById(event.quizId);
      if (quiz == null) {
        emit(const QuizFailure(message: 'الكويز غير موجود'));
        return;
      }
      final questions = await quizRepository.getQuestions(event.quizId);
      if (questions.isEmpty) {
        emit(const QuizFailure(message: 'لا توجد أسئلة في هذا الكويز'));
        return;
      }
      emit(QuizTakingState(quiz: quiz, questions: questions));
    } catch (e) {
      emit(QuizFailure(message: e.toString()));
    }
  }

  void _onAnswerSelected(
      AnswerSelected event,
      Emitter<QuizState> emit,
      ) {
    final current = state;
    if (current is QuizTakingState) {
      emit(current.copyWithAnswer(event.questionIndex, event.selectedOptionIndex));
    }
  }

  Future<void> _onQuizSubmitted(
      QuizSubmitted event,
      Emitter<QuizState> emit,
      ) async {
    final current = state;
    if (current is! QuizTakingState) return;

    final alreadyAttempted = await quizRepository.hasAttempted(
      current.quiz.id,
      event.userId,
    );
    if (alreadyAttempted) {
      emit(const QuizFailure(message: 'لقد أجريت هذا الكويز من قبل'));
      return;
    }

    int score = 0;
    final answers = <String, dynamic>{};

    for (int i = 0; i < current.questions.length; i++) {
      final selected = current.answers[i];
      answers['q$i'] = selected;
      if (selected != null && selected == current.questions[i].correctOptionIndex) {
        score += current.questions[i].marks.toInt();
      }
    }

    final attempt = QuizAttemptModel(
      id: const Uuid().v4(),
      quizId: current.quiz.id,
      userId: event.userId,
      startedAt: DateTime.now(),
      finishedAt: DateTime.now(),
      score: score,
      totalCorrect: score,
      totalQuestions: current.questions.length,
      answers: answers,
      createdAt: DateTime.now(),
    );

    try {
      await quizRepository.saveAttempt(attempt);
      emit(QuizResultState(
        score: score,
        totalQuestions: current.questions.length,
        totalMarks: current.quiz.totalMarks,
      ));
    } catch (e) {
      emit(QuizFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _quizzesSubscription?.cancel();
    return super.close();
  }
}