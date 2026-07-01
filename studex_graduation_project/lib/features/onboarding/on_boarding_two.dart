import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

import '../../core/constants/assets_paths.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_botton.dart';

class OnBoardingTwo extends StatefulWidget {
  const OnBoardingTwo({super.key});

  @override
  State<OnBoardingTwo> createState() => _OnBoardingTwoState();
}

class _OnBoardingTwoState extends State<OnBoardingTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                context.go(AppRoutes.loginRoute);
              },
              child: Text(
                'تخطي',
                style: TextStyle(
                  fontSize: 20.w,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'AbdoMaster',
                ),
              ),
            ),
            Center(child: Image.asset(AssetsPaths.onboarding2)),
            HeightSpacing(25),
            Text(
              'تواصل مع زمايلك بسهولة.',
              style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster'),
            ),
            HeightSpacing(15),
            Text(
              'انضم لغرف مذاكرة عامة أو اعمل غرفة خاصة بيك وتكلم مع أصحابك.',
              style: AppStyles.medium16black.copyWith(fontFamily: 'AbdoMaster'),
            ),

            Spacer(),
            Center(
              child: CustomButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.onBoardingThree);
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
