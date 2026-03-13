import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class StartQuizDetailsSection extends StatelessWidget {
  final String participantsCount;
  final String timeValue;
  final String questionsCount;

  const StartQuizDetailsSection({
    super.key,
    required this.participantsCount,
    required this.timeValue,
    required this.questionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.groups_rounded,
              iconColor: const Color(0xFFE6A817),
              iconBgColor: const Color(0xFFFFF3D6),
              label: 'المشاركون',
              value: '$participantsCount طالب',
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _StatCard(
              icon: Icons.access_time_rounded,
              iconColor: const Color(0xFF26C6A6),
              iconBgColor: const Color(0xFFD6F5EF),
              label: 'الوقت',
              value: '$timeValue دقيقة',
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _StatCard(
              icon: Icons.quiz_rounded,
              iconColor: const Color(0xFF7C6FCD),
              iconBgColor: const Color(0xFFEDEBF9),
              label: 'الأسئلة',
              value: '$questionsCount أسئلة',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(height: 10.h),

          Text(label, style: AppStyles.medium16grey),
          SizedBox(height: 4.h),

          Text(value, style: AppStyles.bold16black),
        ],
      ),
    );
  }
}
