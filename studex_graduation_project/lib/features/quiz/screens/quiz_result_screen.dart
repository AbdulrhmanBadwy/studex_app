import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/features/quiz/widgets/quizResultWidgets/quiz_result_app_bar.dart';
import 'package:studex_graduation_project/features/quiz/widgets/quizResultWidgets/quiz_result_body.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuizResultAppBar(
        title: ' نتيجة الكويز',
        onBackPressed: () => context.pop(),
      ),
      body: QuizResult(
        score: 10,
        total: 10,
        timeSpent: '4:25',
        onBackToRoom: () => context.pop(),
      ),
    );
  }
}
