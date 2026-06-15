import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PasswordResetRequested>(_onPasswordResetRequested);
    on<AuthStateChecked>(_onAuthStateChecked);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'Login failed: no user returned'));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await authRepository.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'Sign up failed: no user returned'));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await authRepository.signOut();
      emit(const AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onPasswordResetRequested(
    PasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await authRepository.resetPassword(email: event.email);
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthStateChecked(
    AuthStateChecked event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final authStream = authRepository.authStateChanges;
      await emit.forEach(
        authStream,
        onData: (user) {
          if (user != null) {
            return AuthSuccess(user: user);
          } else {
            return const AuthLoggedOut();
          }
        },
        onError: (error, stackTrace) {
          return AuthFailure(message: error.toString());
        },
      );
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
