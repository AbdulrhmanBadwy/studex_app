import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/features/auth/login/login_screen.dart';
import 'package:studex_graduation_project/features/auth/register/register_screen.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding_three.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding_two.dart';
import 'package:studex_graduation_project/features/quiz/screens/leaderboard_screen.dart';

import 'app_routes.dart';

class RouterGenerationConfig {
  static final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.leaderboardScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onBoarding,
        builder: (context, state) => const OnBoarding(),
        name: AppRoutes.onBoarding,
      ),

      GoRoute(
        path: AppRoutes.onBoardingTwo,
        builder: (context, state) => const OnBoardingTwo(),
        name: AppRoutes.onBoardingTwo,
      ),

      GoRoute(
        path: AppRoutes.onBoardingThree,
        builder: (context, state) => const OnBoardingThree(),
        name: AppRoutes.onBoardingThree,
      ),

      GoRoute(
        path: AppRoutes.loginRoute,
        builder: (context, state) =>  LoginScreen(),
        name: AppRoutes.loginRoute,
      ),
      GoRoute(
        path: AppRoutes.registerRoute,
        builder: (context, state) => const RegisterScreen(),
        name: AppRoutes.registerRoute,
      ),
      GoRoute(
        path: AppRoutes.leaderboardScreen,
        builder: (context, state) => const LeaderboardScreen(),
        name: AppRoutes.leaderboardScreen,
      ),


    ],
  );
}