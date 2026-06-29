import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizProgressHeader extends StatelessWidget {
  /// Progress value between 0.0 and 1.0
  /// لما تيجي تحسبها هتبقي الاسئلة اللي اتحلت / توتال الاسئلة
  final double progress;

  const QuizProgressHeader({super.key, required this.progress});

  String  get _progressPercent => '${(progress * 100).toInt()}%';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التقدم الإجمالي',

                style: AppStyles.medium16grey.copyWith(
                  fontFamily: 'AbdoMaster',
                ),
              ),
              Text(
                _progressPercent,
                style: AppStyles.primaryBoldBlue18.copyWith(
                  fontFamily: 'AbdoMaster',
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.primaryAllColor,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
