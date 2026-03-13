import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class StartQuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onArrowPressed;

  const StartQuizAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onMenuPressed,
    required this.onArrowPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Colors.black.withOpacity(0.08),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          children: [
            IconButton(
              onPressed: onMenuPressed,
              icon: Icon(
                Icons.more_vert,
                color: const Color(0xFF374151),
                size: 22.sp,
              ),
              splashRadius: 20.r,
              tooltip: 'More options',
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppStyles.bold16black,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppStyles.medium16black,
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onArrowPressed,
              icon: Icon(
                Icons.arrow_forward,
                color: const Color(0xFF475569),
                size: 22.sp,
              ),
              splashRadius: 20.r,
              tooltip: 'Go forward',
            ),
          ],
        ),
      ),
    );
  }
}