import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class MonitoringItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const MonitoringItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor = const Color(0xFF6366F1),
    this.backgroundColor = const Color(0xFF6366F1),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: backgroundColor,
              child: Icon(icon, color: iconColor, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(title, style: AppStyles.medium16grey),
            SizedBox(height: 4.h),
            Text(subtitle, style: AppStyles.bold16black),
          ],
        ),

      ),
    );
  }
}
