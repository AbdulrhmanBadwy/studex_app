import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studex_graduation_project/features/quiz/domain/use_cases/get_quizzes.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/get_quizzes/get_quizes_state.dart';

class GetQuizzesCubit extends Cubit<GetQuizzesState> {
  final GetQuizzes getQuizzesUseCase;

  GetQuizzesCubit(this.getQuizzesUseCase) : super(GetQuizzesInitial());

  void fetchQuizzes(String roomId) {
    emit(GetQuizzesLoading());
    getQuizzesUseCase(roomId).listen(
      (quizzes) => emit(GetQuizzesLoaded(quizzes)),
      onError: (e) => emit(GetQuizzesError(e.toString())),
    );
  }
}
