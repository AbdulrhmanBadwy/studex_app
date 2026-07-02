import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

import '../../core/constants/assets_paths.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_botton.dart';

class OnBoardingThree extends StatefulWidget {
  const OnBoardingThree({super.key});

  @override
  State<OnBoardingThree> createState() => _OnBoardingThreeState();
}

class _OnBoardingThreeState extends State<OnBoardingThree> {
  //final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AssetsPaths.onboarding3),
            Text(
              'اختبارات ذكية ولوحة متابعة.',
              style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster'),
            ),
            HeightSpacing(15),
            Text(
              'اختبر معلوماتك وتابع تقدمك الدراسي من خلال رسوم بيانية تفصيلية.',
              style: AppStyles.medium16black.copyWith(fontFamily: 'AbdoMaster'),
            ),
            Spacer(),
            Center(
              child: CustomButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('seen_onboarding', true);

                  if (!mounted) return;
                  context.go(AppRoutes.loginRoute);
                },
                text: 'ابدأ الآن',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
