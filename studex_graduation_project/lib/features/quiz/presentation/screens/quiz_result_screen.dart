import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/di/injection_container.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/submit_cubit/submit_cubit.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/submit_cubit/submit_state.dart';

import 'package:studex_graduation_project/features/quiz/presentation/widgets/quizResultWidgets/quiz_result_app_bar.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/quizResultWidgets/quiz_result_body.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizEntity quiz;
  final String roomId;
  final List<int> answers;

  const QuizResultScreen({
    super.key,
    required this.quiz,
    required this.roomId,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<SubmitQuizCubit>()
            ..submit(roomId: roomId, quiz: quiz, answers: answers),
      child: Scaffold(
        appBar: QuizResultAppBar(
          title: 'نتيجة الاختبار',
          onBackPressed: () => context.pop(),
        ),
        body: BlocBuilder<SubmitQuizCubit, SubmitQuizState>(
          builder: (context, state) {
            if (state is SubmitQuizLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xff6366F1)),
              );
            }

            if (state is SubmitQuizError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is SubmitQuizSuccess) {
              return QuizResult(
                score: state.score,
                total: state.totalQuestions,
                onBackToRoom: () {
                  context.pushNamed(
                    AppRoutes.roomChatScreen,
                    extra: {'roomId': roomId},
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
