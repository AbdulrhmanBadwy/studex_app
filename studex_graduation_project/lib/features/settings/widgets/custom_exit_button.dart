import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class CustomExitButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomExitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      height: 58.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffFEE2E2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsPaths.exitIcon),
            Text(
              'تسجيل الخروج',
              style: AppStyles.primaryHeadlineStyle.copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
