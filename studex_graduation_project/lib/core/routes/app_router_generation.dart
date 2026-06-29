import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:studex_graduation_project/core/di/injection_container.dart';
import 'package:studex_graduation_project/core/widgets/no_internet_screen.dart';
import 'package:studex_graduation_project/features/auth/login/login_screen.dart';
import 'package:studex_graduation_project/features/auth/repassword/re_password.dart';
import 'package:studex_graduation_project/features/auth/register/register_screen.dart';
import 'package:studex_graduation_project/features/homescreen/home_screen.dart';
import 'package:studex_graduation_project/features/monitoringPanel/dashboard_screen.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding_three.dart';
import 'package:studex_graduation_project/features/auth/splash_screen.dart';
import 'package:studex_graduation_project/features/onboarding/on_boarding_two.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/create_quiz/create_quiz_cubit.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/create_quiz_step_one.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/create_quiz_step_two.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/create_quizz.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/leaderboard_screen.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/quiz_list_screen.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/quiz_result_screen.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/start_quiz_screen.dart';
import 'package:studex_graduation_project/features/quiz/presentation/screens/take_quiz_screen.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/create_quiz_widget/add_question_card.dart';
import 'package:studex_graduation_project/features/rooms/screens/create_room.dart';
import 'package:studex_graduation_project/features/rooms/screens/rooms_list.dart';
import 'package:studex_graduation_project/features/settings/screens/edit_profile_screen.dart';
import 'package:studex_graduation_project/features/settings/screens/settings_screen.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/custom_button_nav_bar.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _roomsNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _monitoringNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _settingsNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  navigatorKey: _rootNavigatorKey,
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
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
      name: AppRoutes.splash,
    ),
    GoRoute(
      path: AppRoutes.loginRoute,
      builder: (context, state) => const LoginScreen(),
      name: AppRoutes.loginRoute,
    ),
    GoRoute(
      path: AppRoutes.registerRoute,
      builder: (context, state) => const RegisterScreen(),
      name: AppRoutes.registerRoute,
    ),
    GoRoute(
      path: AppRoutes.rePasswordRoute,
      builder: (context, state) => const RePassword(),
      name: AppRoutes.rePasswordRoute,
    ),
    GoRoute(
      path: AppRoutes.leaderboardScreen,
      builder: (context, state) => const LeaderboardScreen(),
      name: AppRoutes.leaderboardScreen,
    ),
    GoRoute(
      path: AppRoutes.createRoomScreen,
      builder: (context, state) => const CreateRoom(),
      name: AppRoutes.createRoomScreen,
    ),
    GoRoute(
      path: AppRoutes.createQuizz,
      name: AppRoutes.createQuizz,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return CreateQuizz(roomId: extra['roomId'] ?? '');
      },
    ),
    GoRoute(
      path: AppRoutes.startQuiz,
      name: AppRoutes.startQuiz,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final quiz = extra['quiz'] as QuizEntity;
        final roomId = extra['roomId'] as String;
        return StartQuizScreen(quiz: quiz, roomId: roomId);
      },
    ),
    GoRoute(
      path: AppRoutes.takeQuiz,
      name: AppRoutes.takeQuiz,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return TakeQuizScreen(
          quiz: extra['quiz'] as QuizEntity,
          roomId: extra['roomId'] as String,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editProfileScreen,
      builder: (context, state) => const ProfileEditScreen(),
      name: AppRoutes.editProfileScreen,
    ),
    GoRoute(
      path: AppRoutes.roomChatScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final roomId = extra['roomId']?.toString() ?? '';
        final roomName = extra['roomName']?.toString() ?? '';
        return RoomChatScreen(roomId: roomId, roomName: roomName);
      },
      name: AppRoutes.roomChatScreen,
    ),
    GoRoute(
      path: AppRoutes.quizResultScreen,
      name: AppRoutes.quizResultScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return QuizResultScreen(
          quiz: extra['quiz'] as QuizEntity,
          roomId: extra['roomId'] as String,
          answers: List<int>.from(extra['answers']),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.createQuizStepOne,
      name: AppRoutes.createQuizStepOne,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return CreateQuizStepOne(
          roomId: extra['roomId'] ?? '',
          quizTitle: extra['quizTitle'] ?? '',
          quizDescription: extra['quizDescription'] ?? '',
        );
      },
    ),
    GoRoute(
      path: AppRoutes.quizListScreen,
      name: AppRoutes.quizListScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return QuizListScreen(
          roomId: extra['roomId'] ?? '',
          roomName: extra['roomName'] ?? '',
        );
      },
    ),
    GoRoute(
      path: AppRoutes.createQuizStepTwo,
      name: AppRoutes.createQuizStepTwo,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final questions = (extra['questions'] as List<QuestionData>?) ?? [];
        return BlocProvider(
          create: (_) => sl<CreateQuizCubit>(),
          child: CreateQuizStepTwo(
            roomId: extra['roomId'] ?? '',
            quizTitle: extra['quizTitle'] ?? '',
            quizDescription: extra['quizDescription'] ?? '',
            questions: questions,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.noInternet,
      name: AppRoutes.noInternet,
      builder: (context, state) => const NoInternetScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _TabShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.homeScreen,
              builder: (context, state) => const HomeScreen(),
              name: AppRoutes.homeScreen,
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _roomsNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.roomListScreen,
              builder: (context, state) => const RoomsListScreen(),
              name: AppRoutes.roomListScreen,
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _monitoringNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.monitoringPanel,
              builder: (context, state) => const MonitoringPanelScreen(),
              name: AppRoutes.monitoringPanel,
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.settingsScreen,
              builder: (context, state) => const SettingsScreen(),
              name: AppRoutes.settingsScreen,
            ),
          ],
        ),
      ],
    ),
  ],
);

class _TabShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _TabShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomButtonNavBar(
        currentIndex: navigationShell.currentIndex,
      ),
    );
  }
}
