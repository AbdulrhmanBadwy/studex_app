import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class StartQuizButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const StartQuizButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                label,
                style: AppStyles.bold16white.copyWith(fontFamily: 'AbdoMaster'),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
