import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../core/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _sub;
  bool _navigated = false;

  void _go(String route) {
    if (_navigated || !mounted) return;
    _navigated = true;
    context.go(route);
  }

  @override
  void initState() {
    super.initState();

    final current = AuthService.instance.currentUser;

    // If already logged in → go home
    if (current != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _go(AppRoutes.homeScreen);
      });
      return;
    }

    // Listen for auth changes
    _sub = AuthService.instance.authStateChanges.listen((user) {
      if (user != null) {
        _go(AppRoutes.homeScreen);
      } else {
        _go(AppRoutes.loginRoute);
      }
    });

    // Fallback timeout (safety net)
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted || _navigated) return;

      final cur = AuthService.instance.currentUser;
      if (cur == null) {
        _go(AppRoutes.loginRoute);
      }
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