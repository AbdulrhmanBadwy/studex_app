import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class StartQuizTitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const StartQuizTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(

        children: [
          Text(title, textAlign: TextAlign.center, style: AppStyles.bold20black),
          SizedBox(height: 12.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,

            style: AppStyles.medium16grey,
          ),
        ],
      ),
    );
  }
}
