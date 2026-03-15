import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: AppColors.primaryAllColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90.r),
      ),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        "إنشاء غرفة",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
