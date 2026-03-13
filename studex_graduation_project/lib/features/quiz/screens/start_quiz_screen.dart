import 'package:flutter/material.dart';
import 'package:studex_graduation_project/features/quiz/widgets/abb_bar_start_quiz.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StartQuizAppBar(
        title: 'هندسة',
        subtitle: 'الترم الاول',
        onMenuPressed: () {},
        onArrowPressed: () {},
      ),
      body: SizedBox.shrink(),
    );
  }
}
