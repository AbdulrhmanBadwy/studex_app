import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:studex_graduation_project/core/di/injection_container.dart';

import 'core/config/app_config.dart';
import 'core/config/firebase_config.dart';
import 'core/routes/app_router_generation.dart';
import 'core/routes/app_router_generation.dart' as RouterGenerationConfig;
import 'core/theme/app_themes.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'repositories/auth_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/chat_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  await init();
  runApp(const MyApp());

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: FirebaseAuthRepository()),
        ),
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: FirestoreUserRepository()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: AppConfig.designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: AppConfig.showDebugBanner,
            title: AppConfig.appName,
            theme: AppThemes.lightTheme,
            locale: AppConfig.defaultLocale,
            supportedLocales: AppConfig.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: RouterGenerationConfig.goRouter,
          );
        },
      ),
    );
  }
}
