import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/quiz/widgets/create_quiz_widget/quiz_stepper.dart';
import 'package:studex_graduation_project/features/quiz/widgets/create_quiz_widget/quiz_summary_card.dart';

class CreateQuizStepTwo extends StatelessWidget {
  final String quizTitle;
  final int questionsCount;
  final int timePerQuestion;

  const CreateQuizStepTwo({
    super.key,
    required this.quizTitle,
    required this.questionsCount,
    required this.timePerQuestion,
  });

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
                padding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => GoRouter.of(context).pop(),
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
              QuizStepper(currentStep: 2),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HeightSpacing(20),

                      // Done illustration
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffEEF0FF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_box_outlined,
                          color: const Color(0xff6366F1),
                          size: 48.sp,
                        ),
                      ),
                      HeightSpacing(16),

                      Text(
                        'أوشكت على الانتهاء!',
                        style: TextStyle(
                          fontFamily: 'AbdoMaster',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff0F172A),
                        ),
                      ),
                      HeightSpacing(6),
                      Text(
                        'راجع ملخص الاختبار قبل نشره للطلاب',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'AbdoMaster',
                          fontSize: 13.sp,
                          color: const Color(0xff64748B),
                        ),
                      ),
                      HeightSpacing(24),

                      // Summary card
                      QuizSummaryCard(
                        quizTitle: quizTitle,
                        questionsCount: questionsCount,
                        timePerQuestion: timePerQuestion,
                      ),

                      HeightSpacing(16),

                      // Draft note
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline,
                              size: 14.sp,
                              color: const Color(0xff94A3B8)),
                          SizedBox(width: 4.w),
                          Text(
                            'سيتم حفظ مسودة تلقائياً',
                            style: TextStyle(
                              fontFamily: 'AbdoMaster',
                              fontSize: 12.sp,
                              color: const Color(0xff94A3B8),
                            ),
                          ),
                        ],
                      ),

                      HeightSpacing(100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom buttons
        bottomNavigationBar: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Publish button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: publish quiz
                    GoRouter.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAllColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(Icons.rocket_launch_outlined,
                      color: Colors.white, size: 18.sp),
                  label: Text(
                    'حفظ ونشر الاختبار',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Save draft button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: TextButton(
                  onPressed: () {
                    // TODO: save draft
                    GoRouter.of(context).pop();
                  },
                  child: Text(
                    'حفظ كمسودة',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 14.sp,
                      color: const Color(0xff64748B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}