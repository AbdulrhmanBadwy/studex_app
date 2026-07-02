import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/widgets/custom_botton.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

import '../../core/constants/assets_paths.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('seen_onboarding', true);

                if (!mounted) return;
                context.go(AppRoutes.loginRoute);
              },
              child: Text(
                'تخطي',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Image.asset(AssetsPaths.onboard, width: 340.w, height: 340.h),
            Text(
              'نظّم مذاكرتك في مكان واحد.',
              style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster'),
            ),
            HeightSpacing(15),
            Text(
              'كل اللي محتاجه لتنظيم جدول مذاكرتك في مكان واحد سهل الاستخدام.',
              style: AppStyles.medium16black.copyWith(fontFamily: 'AbdoMaster'),
            ),
            Spacer(),
            Center(
              child: CustomButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.onBoardingTwo);
                },
                text: 'التالي',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
