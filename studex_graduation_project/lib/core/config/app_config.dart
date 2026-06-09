import 'package:flutter/material.dart';

/// General application-level configuration values.
class AppConfig {
  AppConfig._();

  static const String appName = 'Studex App';

  static const Size designSize = Size(390, 884);

  static const bool showDebugBanner = false;

  static const Locale defaultLocale = Locale('ar', 'EG');

  static const List<Locale> supportedLocales = [
    Locale('ar', 'EG'),
    Locale('en', 'US'),
  ];
}
