import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class RoomCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final bool buttonEnabled;
  final VoidCallback? onCardTap;
  final VoidCallback onJoinPressed;

  const RoomCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonEnabled,
    this.onCardTap,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xffEEF0FF)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const HeightSpacing(8),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const WidthSpacing(12),
            SizedBox(
              height: 40.h,
              child: ElevatedButton(
                onPressed: buttonEnabled ? onJoinPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonEnabled
                      ? AppColors.primaryAllColor
                      : const Color(0xffCBD5E1),
                  disabledBackgroundColor: const Color(0xffCBD5E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
