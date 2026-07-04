import 'dart:async';

import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

/// Simple authentication service that exposes the authentication state
/// as a broadcast stream and caches the latest UserModel.
class AuthService {
  AuthService._internal(this._authRepository) {
    _subscription = _authRepository.authStateChanges.listen((user) {
      _currentUser = user;
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
      _controller.add(user);
    });
  }

  final Completer<void> _readyCompleter = Completer<void>();

  /// يكتمل بمجرد وصول أول قيمة فعلية لحالة تسجيل الدخول من Firebase.
  Future<void> get ready => _readyCompleter.future;

  final AuthRepository _authRepository;
  final _controller = StreamController<UserModel?>.broadcast();
  late final StreamSubscription<UserModel?> _subscription;

  UserModel? _currentUser;

  /// Singleton instance using the default FirebaseAuthRepository.
  static final AuthService instance = AuthService._internal(
    FirebaseAuthRepository(),
  );

  /// Broadcast stream of auth state changes (UserModel?).
  Stream<UserModel?> get authStateChanges => _controller.stream;

  /// Synchronously available current user (may be null).
  UserModel? get currentUser => _currentUser;

  /// Dispose resources (only necessary if you create additional instances).
  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}
