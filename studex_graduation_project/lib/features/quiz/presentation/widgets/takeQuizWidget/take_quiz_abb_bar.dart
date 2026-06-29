import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String subject;
  final int currentQuestion;
  final int totalQuestions;
  final VoidCallback? onClose;

  const QuizAppBar({
    super.key,
    required this.subject,
    required this.currentQuestion,
    required this.totalQuestions,
    this.onClose,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _CloseButton(onClose: onClose),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    subject,
                    textAlign: TextAlign.center,
                    style: AppStyles.bold16black.copyWith(
                      fontFamily: 'AbdoMaster',
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'سؤال $currentQuestion من $totalQuestions',
                    textAlign: TextAlign.center,
                    style: AppStyles.primaryBoldBlue18.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24.w),
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback? onClose;

  const _CloseButton({this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Icon(Icons.close, size: 24.r, color: AppColors.greyColor),
    );
  }
}