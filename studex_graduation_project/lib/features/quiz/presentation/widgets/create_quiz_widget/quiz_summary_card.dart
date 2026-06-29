import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizSummaryCard extends StatelessWidget {
  final String quizTitle;
  final String quizDescription; // ✅ added
  final int questionsCount;

  const QuizSummaryCard({
    super.key,
    required this.quizTitle,
    required this.quizDescription, // ✅ added
    required this.questionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملخص الاختبار',
              style: TextStyle(
                fontFamily: 'AbdoMaster',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff0F172A),
              ),
            ),
            SizedBox(height: 16.h),
            _SummaryRow(
              icon: Icons.quiz_outlined,
              iconColor: const Color(0xff6366F1),
              iconBg: const Color(0xffEEF0FF),
              label: 'الاختبار',
              value: quizTitle,
            ),
            SizedBox(height: 12.h),
            _SummaryRow(
              icon: Icons.description_outlined,
              iconColor: const Color(0xff0EA5E9),
              iconBg: const Color(0xffE0F2FE),
              label: 'الوصف',
              value: quizDescription, // ✅
            ),
            SizedBox(height: 12.h),
            _SummaryRow(
              icon: Icons.help_outline_rounded,
              iconColor: const Color(0xffD97706),
              iconBg: const Color(0xffFEF3C7),
              label: 'عدد الأسئلة',
              value: '$questionsCount أسئلة',
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: iconColor, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'AbdoMaster',
            fontSize: 13.sp,
            color: const Color(0xff64748B),
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis, // ✅ handles long text
            style: TextStyle(
              fontFamily: 'AbdoMaster',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff0F172A),
            ),
          ),
        ),
      ],
    );
  }
}