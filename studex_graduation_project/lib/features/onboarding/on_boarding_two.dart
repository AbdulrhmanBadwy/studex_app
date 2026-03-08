import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/widgets/custom_elevated_botton.dart';
import 'package:studex_graduation_project/routes/app_routes.dart';

import '../../core/constants/assets_paths.dart';
import '../widgets/custom_botton.dart';

class OnBoardingTwo extends StatefulWidget {
  const OnBoardingTwo({super.key});

  @override
  State<OnBoardingTwo> createState() => _OnBoardingTwoState();
}

class _OnBoardingTwoState extends State<OnBoardingTwo> {
  final PageController _pageController = PageController();
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
            Center(child: Image.asset(AssetsPaths.onboarding2)),
            SizedBox(height: 25,),
            Text('Communicate with your colleagues easily.',style: AppStyles.bold20black ,),
            SizedBox(height: 15,),
            Text('Join public study rooms or create your own private rooms and chat with your friends.',
            style: AppStyles.medium16black,
            ),

            Spacer(),
            Center(child: CustomBotton(onTap: (){Navigator.pushNamed(context, AppRoutes.OnBoardingThree);}, text: 'Next'),)
          ],
        ),
      ),
    );
  }
}
