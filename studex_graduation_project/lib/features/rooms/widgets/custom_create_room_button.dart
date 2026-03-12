import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class CustomCreateRoomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text ;

  const CustomCreateRoomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      height: 56.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAllColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppStyles.primaryHeadlineStyle.copyWith(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            WidthSpacing(8),
            SvgPicture.asset(AssetsPaths.createRoom, width: 20.w, height: 20.h),
          ],
        ),
      ),
    );
  }
}
