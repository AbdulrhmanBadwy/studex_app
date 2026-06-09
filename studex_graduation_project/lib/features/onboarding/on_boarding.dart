import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRoutes.loginRoute);
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Image.asset(AssetsPaths.onboard , width: 340.w , height: 340.h,),
            Text(
              'Organize your studying in one place.',
              style: AppStyles.bold20black,
            ),
            HeightSpacing( 15),
            Text(
              'Everything you need to organize your study schedule in one easy-to-use place.',
              style: AppStyles.medium16black,
            ),
            Spacer(),
            Center(
              child: CustomButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(AppRoutes.onBoardingTwo);
                },
                text: 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
