import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/create_quiz/create_quiz_cubit.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/create_quiz/create_quiz_state.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/create_quiz_widget/add_question_card.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/create_quiz_widget/quiz_stepper.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/create_quiz_widget/quiz_summary_card.dart';

class CreateQuizStepTwo extends StatelessWidget {
  final String roomId;
  final String quizTitle;
  final String quizDescription;
  final List<QuestionData> questions;

  const CreateQuizStepTwo({
    super.key,
    required this.roomId,
    required this.quizTitle,
    required this.quizDescription,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateQuizCubit, CreateQuizState>(
      listener: (context, state) {
        if (state is CreateQuizSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم نشر الاختبار بنجاح ✅')),
          );
          context.pop();
        } else if (state is CreateQuizError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Directionality(
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
                QuizStepper(currentStep: 2),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HeightSpacing(20),

                        // Done illustration
                        Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: const BoxDecoration(
                            color: Color(0xffEEF0FF),
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
                          quizDescription: quizDescription,
                          questionsCount: questions.length,
                        ),

                        HeightSpacing(100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom button
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: BlocBuilder<CreateQuizCubit, CreateQuizState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: state is CreateQuizLoading
                        ? null
                        : () {
                            context.read<CreateQuizCubit>().createQuiz(
                              roomId: roomId,
                              title: quizTitle,
                              description: quizDescription,
                              questions: questions,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAllColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    icon: state is CreateQuizLoading
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.rocket_launch_outlined,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                    label: Text(
                      state is CreateQuizLoading
                          ? 'جاري النشر...'
                          : 'حفظ ونشر الاختبار',
                      style: TextStyle(
                        fontFamily: 'AbdoMaster',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
