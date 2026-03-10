import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widgets/spacing.dart';

class CustomHeadlineLeaderboardScreen extends StatelessWidget {
  const CustomHeadlineLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WidthSpacing(115),
        Center(
          child: Text(
            'لوحة المتصدرين',
            style: AppStyles.primaryHeadlineStyle,
          ),
        ),
        WidthSpacing(68),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_rounded,
            size: 27.sp,
            color: AppColors.blackHeadLine,
          ),
        ),
      ],
    );
  }
}
