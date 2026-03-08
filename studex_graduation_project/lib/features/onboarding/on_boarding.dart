import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/widgets/custom_botton.dart';
import 'package:studex_graduation_project/features/widgets/custom_elevated_botton.dart';
import 'package:studex_graduation_project/routes/app_routes.dart';

import '../../core/constants/assets_paths.dart';
import 'on_boarding_two.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
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
            TextButton(onPressed: (){
              Navigator.pushNamed(context, AppRoutes.loginRoute);

            },
                child: Text('Skip',style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor),)
            ),
            Image.asset(AssetsPaths.onboarding1),
            Text('Organize your studying in one place.',style: AppStyles.bold20black ,),
            SizedBox(height: 15,),
            Text('Everything you need to organize your study schedule in one easy-to-use place.',
            style: AppStyles.medium16black,
            ),
            Spacer(),
            Center(child: CustomBotton(onTap: (){Navigator.pushNamed(context, AppRoutes.OnBoardingTwo);}, text: 'Next'),)

          ],
        ),
      ),
    );
  }
}
