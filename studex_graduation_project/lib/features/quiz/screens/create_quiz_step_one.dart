import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/quiz/widgets/create_quiz_widget/add_question_card.dart';
import 'package:studex_graduation_project/features/quiz/widgets/create_quiz_widget/quiz_stepper.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

class CreateQuizStepOne extends StatefulWidget {
  final String quizTitle;
  final String quizDescription;
  final int timePerQuestion;

  const CreateQuizStepOne({
    super.key,
    required this.quizTitle,
    required this.quizDescription,
    required this.timePerQuestion,
  });

  @override
  State<CreateQuizStepOne> createState() => _CreateQuizStepOneState();
}

class _CreateQuizStepOneState extends State<CreateQuizStepOne> {
  int _questionCount = 1;

  void _addQuestion() {
    setState(() => _questionCount++);
  }

  void _removeQuestion(int index) {
    if (_questionCount > 1) {
      setState(() => _questionCount--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F6F6),
        body: SafeArea(
          child: Column(
            children: [
              // AppBar row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: const Color(0xff0F172A),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'إنشاء اختبار جديد',
                      style: AppStyles.primaryHeadlineStyle,
                    ),
                  ],
                ),
              ),

              // Stepper
              QuizStepper(currentStep: 1),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        _questionCount,
                        (index) => AddQuestionCard(
                          questionNumber: index + 1,
                          onDelete: _questionCount > 1
                              ? () => _removeQuestion(index)
                              : null,
                        ),
                      ),

                      // Add question button
                      GestureDetector(
                        onTap: _addQuestion,
                        child: Container(
                          width: double.infinity,
                          height: 52.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xff6366F1),
                              width: 1.5,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: const Color(0xff6366F1),
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'إضافة سؤال آخر',
                                style: TextStyle(
                                  fontFamily: 'AbdoMaster',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff6366F1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      HeightSpacing(100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Next button
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  AppRoutes.createQuizStepTwo,
                  extra: {
                    'quizTitle': widget.quizTitle,
                    'questionsCount': _questionCount,
                    'timePerQuestion': widget.timePerQuestion,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryAllColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'التالي',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
