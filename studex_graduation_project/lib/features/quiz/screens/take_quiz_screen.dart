import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/quiz/widgets/takeQuizWidget/quiz_progress.dart';

import 'package:studex_graduation_project/features/quiz/widgets/takeQuizWidget/quiz_view.dart';
import 'package:studex_graduation_project/features/quiz/widgets/takeQuizWidget/take_quiz_abb_bar.dart';

class TakeQuizScreen extends StatefulWidget {
  const TakeQuizScreen({super.key});

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: QuizAppBar(
        subject: 'رياضة',
        currentQuestion: 2,
        totalQuestions: 10,
        remainingSeconds: 1000,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            QuizProgressHeader(progress: 0.87),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: QuizQuestionWidget(
                  question:
                      "ما هي الخطوة الأولى في دورة حياة تطوير البرمجيات (SDLC)؟",
                  imagePath:
                      "https://datarob.com/content/images/size/w2000/2019/08/SDLC-stages.png",
                  options: const [
                    "جمع المتطلبات والتحليل",
                    "التصميم والهيكلة الفنية",
                    "التطوير والبرمجة الفعلية",
                    "الاختبار وضمان الجودة",
                  ],
                  selectedIndex: selectedOption,
                  onOptionSelected: (index) {
                    setState(() {
                      selectedOption = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAllColor,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'التالي',
                      style: AppStyles.bold16white.copyWith(
                        fontFamily: 'AbdoMaster',
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
