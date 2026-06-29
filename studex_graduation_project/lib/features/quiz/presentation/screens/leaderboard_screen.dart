import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/custom_first_three.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/custom_headline_screen.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/custom_item.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeadlineScreen(
              title: 'لوحة المتصدرين',
              onPressed: () => context.pop(),
            ),
            HeightSpacing(22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomFirstThree(
                  name: 'ريم خالد',
                  order: '2',
                  size: 80,
                  image: AssetsPaths.onboarding2,
                  borderColor: const Color(0xff948E73),
                  orderBackgroundColor: const Color(0xffF1E5D1),
                  orderTextColor: const Color(0xff948E73),
                ),
                WidthSpacing(15),
                CustomFirstThree(
                  name: 'سارة أحمد',
                  order: '1',
                  size: 110,
                  borderColor: AppColors.primaryAllColor,
                  orderBackgroundColor: AppColors.primaryAllColor,
                ),
                WidthSpacing(15),

                CustomFirstThree(
                  name: 'محمد علي',
                  order: '3',
                  size: 80,
                  borderColor: const Color(0xffD1D9E4),
                  orderBackgroundColor: const Color(0xffE2E8F0),
                  orderTextColor: const Color(0xff475569),
                ),
              ],
            ),
            HeightSpacing(28),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomItem(
                    name: 'عبدالرحمن بدوي',
                    order: '$index',
                    image: AssetsPaths.onboarding3,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return HeightSpacing(12);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
