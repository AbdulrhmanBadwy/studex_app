import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';

class StartQuizScreen extends StatelessWidget {
  final QuizEntity quiz;
  final String roomId;

  const StartQuizScreen({
    super.key,
    required this.quiz,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F6F6),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar
                Row(
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
                      'تفاصيل الاختبار',
                      style: TextStyle(
                        fontFamily: 'AbdoMaster',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff0F172A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF0FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.quiz_outlined,
                      color: const Color(0xff6366F1),
                      size: 48.sp,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Center(
                  child: Text(
                    quiz.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0F172A),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Center(
                  child: Text(
                    quiz.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 13.sp,
                      color: const Color(0xff64748B),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                // Info card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xffEEF0FF),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.help_outline_rounded,
                              color: const Color(0xff6366F1),
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '${quiz.questions.length}',
                            style: TextStyle(
                              fontFamily: 'AbdoMaster',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0F172A),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'سؤال',
                            style: TextStyle(
                              fontFamily: 'AbdoMaster',
                              fontSize: 12.sp,
                              color: const Color(0xff94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Start button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        AppRoutes.takeQuiz,
                        extra: {
                          'quiz': quiz,
                          'roomId': roomId,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'بدء الاختبار',
                      style: TextStyle(
                        fontFamily: 'AbdoMaster',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}