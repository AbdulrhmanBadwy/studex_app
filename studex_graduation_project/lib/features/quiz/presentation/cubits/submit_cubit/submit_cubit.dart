import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/use_cases/submit_quiz_answer.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/submit_cubit/submit_state.dart';

class SubmitQuizCubit extends Cubit<SubmitQuizState> {
  final SubmitQuizAnswers submitQuizAnswers;

  SubmitQuizCubit(this.submitQuizAnswers) : super(SubmitQuizInitial());

  Future<void> submit({
    required String roomId,
    required QuizEntity quiz,
    required List<int> answers,
  }) async {
    emit(SubmitQuizLoading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(SubmitQuizError('يجب تسجيل الدخول أولاً'));
        return;
      }

      await submitQuizAnswers(roomId, quiz, userId, answers);

      int score = 0;
      for (int i = 0; i < quiz.questions.length; i++) {
        if (quiz.questions[i].correctOptionIndex == answers[i]) {
          score++;
        }
      }

      emit(
        SubmitQuizSuccess(score: score, totalQuestions: quiz.questions.length),
      );
    } catch (e) {
      emit(SubmitQuizError(e.toString()));
    }
  }
}
