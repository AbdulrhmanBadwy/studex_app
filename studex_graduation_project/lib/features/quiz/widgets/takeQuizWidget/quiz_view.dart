import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizQuestionWidget extends StatelessWidget {
  final String question;
  final String imagePath;
  final List<String> options;
  final int? selectedIndex;
  final Function(int) onOptionSelected;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.imagePath,
    required this.options,
    this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 312.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                question,
                style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster'),
              ),
              SizedBox(height: 14.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  imagePath,
                  height: 174.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        ...List.generate(options.length, (index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onOptionSelected(index),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryAllColor
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      options[index],
                      style: isSelected
                          ? AppStyles.primaryBoldBlue18.copyWith(
                              fontFamily: 'AbdoMaster',
                            )
                          : AppStyles.bold20black.copyWith(
                              fontFamily: 'AbdoMaster',
                            ),
                    ),
                  ),
                  Container(
                    height: 24.h,
                    width: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey.shade400, width: 2.w),
                      color: isSelected
                          ? AppColors.primaryLight
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: AppColors.primaryAllColor,
                            size: 16.sp,
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
