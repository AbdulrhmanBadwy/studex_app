import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String subject;
  final int currentQuestion;
  final int totalQuestions;
  final int remainingSeconds;
  final VoidCallback? onClose;

  const QuizAppBar({
    super.key,
    required this.subject,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.remainingSeconds,
    this.onClose,
  });

  String get _formattedTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

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
            _TimerPill(formattedTime: _formattedTime),
          ],
        ),
      ),
    );
  }
}

class _TimerPill extends StatelessWidget {
  final String formattedTime;

  const _TimerPill({required this.formattedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 16.r,
            color: AppColors.primaryAllColor,
          ),
          SizedBox(width: 6.w),
          Text(
            formattedTime,
            style: AppStyles.primaryBoldBlue18.copyWith(fontSize: 18.sp),
          ),
        ],
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
