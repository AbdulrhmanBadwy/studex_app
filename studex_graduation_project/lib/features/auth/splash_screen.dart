import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../core/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    final current = AuthService.instance.currentUser;
    if (current != null) {
      // Already signed in -> go to home
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.homeScreen);
      });
      return;
    }

    // Listen for first auth state event and navigate accordingly.
    _sub = AuthService.instance.authStateChanges.listen((user) {
      if (user != null) {
        context.go(AppRoutes.homeScreen);
      } else {
        context.go(AppRoutes.loginRoute);
      }
    });

    // Fallback: if no event within 5 seconds, go to login
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      final cur = AuthService.instance.currentUser;
      if (cur == null) context.go(AppRoutes.loginRoute);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
