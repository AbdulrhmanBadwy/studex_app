import 'package:flutter/material.dart';
import 'package:studex_graduation_project/features/auth/login/login_screen.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding_three.dart';
import 'package:studex_graduation_project/routes/app_routes.dart';

import 'features/auth/register/register_screen.dart';
import 'features/onboarding/on_boarding_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.OnBoarding,
      routes: {
        AppRoutes.OnBoarding: (context) => OnBoarding(),
        AppRoutes.OnBoardingTwo: (context) => OnBoardingTwo(),
        AppRoutes.OnBoardingThree: (context) => OnBoardingThree(),
        AppRoutes.loginRoute: (context) => LoginScreen(),
        AppRoutes.registerRoute: (context) => RegisterScreen(),

      }
    );
  }
}


