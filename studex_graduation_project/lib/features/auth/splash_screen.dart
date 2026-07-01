import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/assets_paths.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _minimumSplashDuration = Duration(milliseconds: 2800);

  StreamSubscription? _sub;
  Timer? _fallbackTimer;
  bool _navigated = false;
  bool _minDurationDone = false;
  String? _pendingRoute;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  void _go(String route) {
    if (_navigated || !mounted) return;
    _navigated = true;
    context.go(route);
  }

  void _queueOrGo(String route) {
    if (_navigated) return;

    if (_minDurationDone) {
      _go(route);
    } else {
      _pendingRoute = route;
    }
  }

  Future<void> _handleNavigationFlow() async {
    Future.delayed(_minimumSplashDuration, () {
      if (!mounted || _navigated) return;

      _minDurationDone = true;
      if (_pendingRoute != null) {
        _go(_pendingRoute!);
      }
    });

    final current = AuthService.instance.currentUser;

    if (current != null) {
      _queueOrGo(AppRoutes.homeScreen);
      return;
    }

    _queueOrGo(AppRoutes.onBoarding);
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curved = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curved);
    _scaleAnimation = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
    _handleNavigationFlow();
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    _sub?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              AssetsPaths.appIcon,
              width: 150.w,
              height: 150.h,
            ),
          ),
        ),
      ),
    );
  }
}
