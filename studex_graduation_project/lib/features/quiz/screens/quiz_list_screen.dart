import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_bloc.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_event.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_state.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/models/quiz_model.dart';
import 'package:studex_graduation_project/repositories/quiz_repository.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(quizRepository: FirestoreQuizRepository())
        ..add(const LoadQuizzesRequested()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffF8F9FD),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text('الاختبارات المتاحة',
                style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster')),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.pushNamed(AppRoutes.createQuizz),
            backgroundColor: AppColors.primaryAllColor,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text('اختبار جديد',
                style: const TextStyle(color: Colors.white, fontFamily: 'AbdoMaster')),
          ),
          body: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuizLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is QuizFailure) {
                return Center(
                  child: Text(state.message, style: AppStyles.medium16grey),
                );
              }

              if (state is QuizzesLoaded) {
                if (state.quizzes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.quiz_outlined,
                            size: 64.sp, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        Text('لا توجد اختبارات متاحة',
                            style: AppStyles.medium16grey.copyWith(
                                fontFamily: 'AbdoMaster')),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.quizzes.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, i) =>
                      _QuizCard(quiz: state.quizzes[i]),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final QuizModel quiz;

  const _QuizCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoutes.startQuiz,
        extra: {'quizId': quiz.id},
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: const Color(0xffEEF0FF),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(Icons.quiz_outlined,
                  color: AppColors.primaryAllColor, size: 28.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(quiz.title,
                      style: AppStyles.bold16black.copyWith(
                          fontFamily: 'AbdoMaster')),
                  SizedBox(height: 4.h),
                  if (quiz.description.isNotEmpty)
                    Text(quiz.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.medium16grey.copyWith(
                            fontFamily: 'AbdoMaster', fontSize: 13.sp)),
                  SizedBox(height: 6.h),
                  Text('${quiz.totalMarks} درجة',
                      style: TextStyle(
                          fontFamily: 'AbdoMaster',
                          fontSize: 12.sp,
                          color: AppColors.primaryAllColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Icon(Icons.arrow_back_ios,
                color: AppColors.primaryAllColor, size: 16.sp),
          ],
        ),
      ),
    );
  }
}