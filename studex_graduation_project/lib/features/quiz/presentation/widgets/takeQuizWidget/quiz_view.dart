import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizQuestionWidget extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final Function(int) onOptionSelected;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.options,
    this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: Colors.white,
            border: Border.all(color: const Color(0xffE8ECF4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            question,
            textAlign: TextAlign.right,
            style: AppStyles.bold20black.copyWith(
              fontFamily: 'AbdoMaster',
              fontSize: 16.sp,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Options
        ...List.generate(options.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onOptionSelected(index),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xffEEF0FF)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryAllColor
                      : const Color(0xffE8ECF4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      options[index],
                      textAlign: TextAlign.right,
                      style: isSelected
                          ? AppStyles.primaryBoldBlue18.copyWith(
                        fontFamily: 'AbdoMaster',
                        fontSize: 14.sp,
                      )
                          : AppStyles.bold20black.copyWith(
                        fontFamily: 'AbdoMaster',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    height: 24.h,
                    width: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? null
                          : Border.all(
                        color: Colors.grey.shade400,
                        width: 2.w,
                      ),
                      color: isSelected
                          ? AppColors.primaryAllColor
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14.sp,
                    )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),

        SizedBox(height: 16.h),
      ],
    );
  }
}