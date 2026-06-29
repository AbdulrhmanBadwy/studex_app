/// Centralized Firestore collection names.
///
/// Use these constants throughout the app to avoid hardcoding collection
/// names in multiple places and to make future renames safer.
class FirestoreCollections {
  FirestoreCollections._();

  static const String users = 'users';
  static const String rooms = 'rooms';
  static const String quizzes = 'quizzes';
  static const String quizAttempts = 'quiz_attempts';
  static const String notifications = 'notifications';
}
