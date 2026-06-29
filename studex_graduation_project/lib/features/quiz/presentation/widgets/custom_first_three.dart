import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class CustomFirstThree extends StatelessWidget {
  final String? name;
  final String? image;
  final String? order;
  final double? size;
  final Color? borderColor;
  final Color? orderBackgroundColor;
  final Color? orderTextColor;

  const CustomFirstThree({
    super.key,
    this.name,
    this.image,
    this.order,
    this.size,
    this.borderColor,
    this.orderBackgroundColor,
    this.orderTextColor,
  });

  @override
  Widget build(BuildContext context) {
    double currentSize = (size ?? 90).w;

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none, // مهم جداً عشان الرقم يبرز لبره
          children: [
            Container(
              width: currentSize,
              height: currentSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .5),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: borderColor ?? AppColors.primaryAllColor,
                  width: 4.w,
                ),
                image: DecorationImage(
                  image: AssetImage(image ?? AssetsPaths.defaultUserAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              bottom: -15.h,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: orderBackgroundColor ?? AppColors.primaryAllColor,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    order ?? '1',
                    style: TextStyle(
                      color: orderTextColor ?? Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        HeightSpacing(25),
        Text(
          name ?? '',
          style: AppStyles.primaryHeadlineStyle.copyWith(fontSize: 14.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
