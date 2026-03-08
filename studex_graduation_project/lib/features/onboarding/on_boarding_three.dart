import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/widgets/custom_elevated_botton.dart';
import 'package:studex_graduation_project/routes/app_routes.dart';

import '../../core/constants/assets_paths.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 40,horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AssetsPaths.onboarding3),
            Text('Smart tests and tracking board.',style: AppStyles.bold20black ,),
            SizedBox(height: 15,),
            Text('Test your knowledge and track your academic progress through detailed graphs.',
            style: AppStyles.medium16black,
            ),
            Spacer(),
            Center(child: CustomBotton(onTap: (){Navigator.pushNamed(context, AppRoutes.loginRoute);}, text: 'Start Now'),)
          ],
        ),
      ),
    );
  }
}
