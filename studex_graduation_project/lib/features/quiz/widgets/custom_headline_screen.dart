import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widgets/spacing.dart';

class CustomHeadlineScreen extends StatelessWidget {
  final String title ;
  const CustomHeadlineScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WidthSpacing(35),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            size: 27.sp,
            color: AppColors.blackHeadLine,
          ),
        ),
        WidthSpacing(60),
        Center(
          child: Text(
            title,
            style: AppStyles.primaryHeadlineStyle,
          ),
        ),
      ],
    );
  }
}
