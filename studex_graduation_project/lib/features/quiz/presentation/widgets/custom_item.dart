import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class CustomItem extends StatelessWidget {
  final String? name;
  final String? image;
  final String? order;
  const CustomItem({super.key, this.name, this.image, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color(0xffF8FAFC),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Text(
                order ?? '',
                style: AppStyles.primaryHeadlineStyle.copyWith(
                  color: const Color(0xff94A3B8),
                  fontSize: 16.sp,
                ),
              ),
              WidthSpacing(12),
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              WidthSpacing(12),
              Text(
                name ?? '',
                style: AppStyles.primaryHeadlineStyle.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
