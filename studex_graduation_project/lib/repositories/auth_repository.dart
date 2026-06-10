import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../core/constants/user_roles.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;
  Future<UserModel?> signIn({required String email, required String password});
  Future<UserModel?> signUp({required String email, required String password, required String name});
  Future<void> signOut();
  Future<void> resetPassword({required String email});
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  UserModel? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      role: UserRoles.student, // default role
    );
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_mapFirebaseUser);
  }

  @override
  Future<UserModel?> signIn({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapFirebaseUser(userCredential.user);
  }

  @override
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;
      return _mapFirebaseUser(updatedUser);
    }
    return _mapFirebaseUser(user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
