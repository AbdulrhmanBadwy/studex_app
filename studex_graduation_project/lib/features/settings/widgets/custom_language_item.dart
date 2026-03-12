import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

import '../../../core/theme/app_styles.dart';

class CustomLanguageItem extends StatelessWidget {
  final String title;
  final String icon;
  final String currentLanguage;
  final VoidCallback onTap;

  const CustomLanguageItem({
    super.key,
    required this.title,
    required this.icon,
    required this.currentLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 356.w,
      height: 73.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: AppStyles.textItemInSettings),

        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xffF3F4F9),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.h,
          ),
        ),

        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              currentLanguage,
              style: AppStyles.textItemInSettings.copyWith(
                color: const Color(0xff94A3B8),
                fontSize: 14.sp,
              ),
            ),
            WidthSpacing(5),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16.sp,
              color: const Color(0xff94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}