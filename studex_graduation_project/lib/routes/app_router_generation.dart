static final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.roomChatScreen, 
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
      builder: (context, state) => const LoginScreen(),
      name: AppRoutes.loginRoute,
    ),
    GoRoute(
      path: AppRoutes.registerRoute,
      builder: (context, state) => const RegisterScreen(),
      name: AppRoutes.registerRoute,
    ),
    GoRoute(
      path: AppRoutes.monitoringPanel,
      builder: (context, state) => const MonitoringPanelScreen(),
      name: AppRoutes.monitoringPanel,
    ),
    GoRoute(
      path: AppRoutes.leaderboardScreen,
      builder: (context, state) => const LeaderboardScreen(),
      name: AppRoutes.leaderboardScreen,
    ),
    GoRoute(
      path: AppRoutes.settingsScreen,
      builder: (context, state) => const SettingsScreen(),
      name: AppRoutes.settingsScreen,
    ),
    GoRoute(
      path: AppRoutes.createRoomScreen,
      builder: (context, state) => const CreateRoom(),
      name: AppRoutes.createRoomScreen,
    ),
    GoRoute(
      path: AppRoutes.createQuizz,
      builder: (context, state) => const CreateQuizz(),
      name: AppRoutes.createQuizz,
    ),
    GoRoute(
      path: AppRoutes.startQuiz,
      builder: (context, state) => const StartQuizScreen(),
      name: AppRoutes.startQuiz,
    ),
    GoRoute(
      path: AppRoutes.takeQuiz,
      builder: (context, state) => const TakeQuizScreen(),
      name: AppRoutes.takeQuiz,
    ),
    GoRoute(
      path: AppRoutes.monitoringDashboardScreen,
      builder: (context, state) => const MonitoringPanelScreen(),
      name: AppRoutes.monitoringDashboardScreen,
    ),
    GoRoute(
      path: AppRoutes.editProfileScreen,
      builder: (context, state) => const ProfileEditScreen(),
      name: AppRoutes.editProfileScreen,
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
      name: AppRoutes.homeScreen,
    ),
    GoRoute(
      path: AppRoutes.roomListScreen,
      builder: (context, state) => const RoomsListScreen(),
      name: AppRoutes.roomListScreen,
    ),
    GoRoute(
      path: AppRoutes.roomChatScreen,
      builder: (context, state) => const RoomChatScreen(),
      name: AppRoutes.roomChatScreen,
    ),
  ],
);