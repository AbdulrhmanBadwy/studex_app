import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

/// Centralizes Firebase SDK configuration and initialization.
///
/// Platform-specific credentials remain in the generated
/// [DefaultFirebaseOptions] file produced by FlutterFire CLI.
class FirebaseConfig {
  FirebaseConfig._();

  static FirebaseOptions get options => DefaultFirebaseOptions.currentPlatform;

  static String get projectId => options.projectId;

  static String? get storageBucket => options.storageBucket;

  static String get messagingSenderId => options.messagingSenderId;

  static Future<FirebaseApp> initialize() {
    return Firebase.initializeApp(options: options);
  }
}
