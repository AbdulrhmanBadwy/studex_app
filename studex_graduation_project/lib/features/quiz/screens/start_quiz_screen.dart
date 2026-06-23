import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/abb_bar_start_quiz.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_button.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_details.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_title.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

class StartQuizScreen extends StatelessWidget {
  final String quizId;

  const StartQuizScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: StartQuizAppBar(
        title: 'اختبار',
        subtitle: 'ابدأ الإجابة',
        onMenuPressed: () {},
        onArrowPressed: () => context.pop(),
      ),
      body: Column(
        children: [
          SizedBox(height: 32.h),
          Center(
            child: Container(
              width: 180.w,
              height: 180.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F2E),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.quiz_outlined,
                  color: AppColors.primaryLight, size: 80.sp),
            ),
          ),
          SizedBox(height: 32.h),
          StartQuizTitleSection(
            title: 'جاهز تبدأ الاختبار؟',
            subtitle: 'اقرأ كل سؤال بتأن واختر الإجابة الصحيحة.',
          ),
          SizedBox(height: 16.h),
          StartQuizDetailsSection(
            participantsCount: '-',
            timeValue: '-',
            questionsCount: '-',
          ),
          SizedBox(height: 40.h),
          StartQuizButton(
            label: 'ابدأ الاختبار الآن',
            onPressed: () => context.pushNamed(
              AppRoutes.takeQuiz,
              extra: {'quizId': quizId},
            ),
          ),
        ],
      ),
    );
  }
}