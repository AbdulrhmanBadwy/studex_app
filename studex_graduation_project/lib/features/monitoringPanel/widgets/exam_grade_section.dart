import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class ExamGradesSection extends StatefulWidget {
  const ExamGradesSection({super.key});

  @override
  State<ExamGradesSection> createState() => _ExamGradesSectionState();
}

class _ExamGradesSectionState extends State<ExamGradesSection> {
  final List<Map<String, dynamic>> quizzes = [
    {'label': 'كويز 1', 'grade': 90},
    {'label': 'كويز 2', 'grade': 65},
    {'label': 'كويز 3', 'grade': 78},
    {'label': 'كويز 4', 'grade': 50},
    {'label': 'كويز 5', 'grade': 88},
  ]; // for test

  Color _barColor(int grade) {
    if (grade >= 80) return const Color(0xFF4CAF50);
    if (grade >= 60) return const Color(0xFFFFA726);
    return const Color(0xFFEF5350);
  } // دا بعد كدا هيتحسب علي حسب نسبة الدرجة كام % يعني

  @override
  Widget build(BuildContext context) {
    final maxGrade = quizzes
        .map((e) => e['grade'] as int)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('درجات الإختبارات', style: AppStyles.bold16black),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.more_horiz, color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: quizzes.map((quiz) {
              final grade = quiz['grade'] as int;
              final barHeight = (grade / maxGrade) * 130.h;

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$grade',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: _barColor(grade),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    width: 32.w,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: _barColor(grade),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    quiz['label'] as String,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
