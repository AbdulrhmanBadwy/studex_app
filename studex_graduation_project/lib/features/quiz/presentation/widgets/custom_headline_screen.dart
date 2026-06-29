import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class CustomHeadlineScreen extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomHeadlineScreen({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WidthSpacing(35),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_back,
            size: 27.sp,
            color: AppColors.blackHeadLine,
          ),
        ),
        WidthSpacing(60),
        Center(child: Text(title, style: AppStyles.primaryHeadlineStyle)),
      ],
    );
  }
}
