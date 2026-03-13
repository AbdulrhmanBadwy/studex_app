import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class CustomBotton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomBotton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(48.r),
        ),
        child: Center(child: Text(text, style: AppStyles.medium16black)),
      ),
    );
  }
}
