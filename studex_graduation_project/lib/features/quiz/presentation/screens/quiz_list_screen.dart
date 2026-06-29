import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/di/injection_container.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/get_quizzes/get_quizes_cubit.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/get_quizzes/get_quizes_state.dart';

class QuizListScreen extends StatelessWidget {
  final String roomId;
  final String roomName;

  const QuizListScreen({
    super.key,
    required this.roomId,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetQuizzesCubit>()..fetchQuizzes(roomId),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffF8F6F6),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(
                AppRoutes.createQuizz,
                extra: {'roomId': roomId},
              );
            },
            backgroundColor: const Color(0xff6366F1),
            child: Icon(Icons.add, color: Colors.white, size: 24.sp),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

          body: SafeArea(
            child: Column(
              children: [
                // AppBar
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
                      Expanded(
                        child: Text(
                          'اختبارات $roomName',
                          style: TextStyle(
                            fontFamily: 'AbdoMaster',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Body
                Expanded(
                  child: BlocBuilder<GetQuizzesCubit, GetQuizzesState>(
                    builder: (context, state) {
                      if (state is GetQuizzesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff6366F1),
                          ),
                        );
                      }

                      if (state is GetQuizzesError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              fontFamily: 'AbdoMaster',
                              fontSize: 14.sp,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }

                      if (state is GetQuizzesLoaded) {
                        if (state.quizzes.isEmpty) {
                          return const _EmptyState();
                        }
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          itemCount: state.quizzes.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final quiz = state.quizzes[index];
                            return _QuizCard(
                              quiz: quiz,
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.startQuiz,
                                  extra: {'quiz': quiz, 'roomId': roomId},
                                );
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 64.sp,
            color: const Color(0xffCBD5E1),
          ),
          SizedBox(height: 16.h),
          Text(
            'لا يوجد اختبارات بعد',
            style: TextStyle(
              fontFamily: 'AbdoMaster',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff94A3B8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'سيظهر هنا الاختبارات عند إضافتها',
            style: TextStyle(
              fontFamily: 'AbdoMaster',
              fontSize: 13.sp,
              color: const Color(0xffCBD5E1),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final QuizEntity quiz;
  final VoidCallback onTap;

  const _QuizCard({required this.quiz, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xffE8ECF4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xffEEF0FF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.quiz_outlined,
                color: const Color(0xff6366F1),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.title,
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0F172A),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    quiz.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 12.sp,
                      color: const Color(0xff94A3B8),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline_rounded,
                        size: 13.sp,
                        color: const Color(0xff6366F1),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${quiz.questions.length} أسئلة',
                        style: TextStyle(
                          fontFamily: 'AbdoMaster',
                          fontSize: 12.sp,
                          color: const Color(0xff6366F1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_back_ios,
              size: 16.sp,
              color: const Color(0xffCBD5E1),
            ),
          ],
        ),
      ),
    );
  }
}
