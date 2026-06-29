import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/question_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/domain/use_cases/create_quiz_use_case.dart';

import 'package:studex_graduation_project/features/quiz/presentation/cubits/create_quiz/create_quiz_state.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/create_quiz_widget/add_question_card.dart';
import 'package:uuid/uuid.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  final CreateQuizUseCase createQuizUseCase;

  CreateQuizCubit(this.createQuizUseCase) : super(CreateQuizInitial());

  Future<void> createQuiz({
    required String roomId,
    required String title,
    required String description,
    required List<QuestionData> questions,
  }) async {
    emit(CreateQuizLoading());

    try {
      final quiz = QuizEntity(
        id: const Uuid().v4(),
        title: title,
        description: description,
        questions: questions
            .map(
              (q) => QuestionEntity(
                question: q.question,
                options: q.options,
                correctOptionIndex: q.correctAnswerIndex,
              ),
            )
            .toList(),
      );

      await createQuizUseCase(quiz, roomId);
      emit(CreateQuizSuccess());
    } catch (e) {
      emit(CreateQuizError(e.toString()));
    }
  }
}
