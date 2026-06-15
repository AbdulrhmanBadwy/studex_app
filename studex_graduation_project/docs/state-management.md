# State Management Solution — Selected: Bloc

## Decision

**Selected:** Bloc (flutter_bloc ^8.1.3 + equatable ^2.0.5)

## Rationale

- **Event-Driven Architecture**: Bloc uses clear event/state separation, making state transitions explicit and testable.
- **Scalability**: Well-suited for managing complex state and business logic across the application.
- **Community**: Large ecosystem with extensive examples and strong community support.
- **Predictable**: State changes are triggered by discrete events, reducing unexpected side effects.
- **Team Ready**: Single developer can efficiently implement Bloc patterns.

## Alternatives Considered

- **Riverpod**: More modern but less event-driven; better for simpler state.
- **Provider**: Lightweight but less structured than Bloc.

## Core Concepts

### Events
Represent user actions or system events:
```dart
sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
```

### States
Represent the UI state:
```dart
sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
```

### Bloc
Processes events and emits states:
```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signOut();
    emit(AuthInitial());
  }
}
```

### Using Bloc in Widgets

```dart
// Wrap app with BlocProvider
BlocProvider(
  create: (context) => AuthBloc(authRepository: AuthRepository()),
  child: const MyApp(),
);

// Consume state in a widget
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    return switch (state) {
      AuthSuccess(:final user) => Text('Welcome ${user.name}'),
      AuthLoading() => const CircularProgressIndicator(),
      AuthFailure(:final message) => Text('Error: $message'),
      AuthInitial() => const SizedBox.shrink(),
    };
  },
);

// Listen to state changes (for side effects)
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccess) {
      context.go(AppRoutes.homeScreen);
    }
  },
  child: const Scaffold(),
);
```

### Testing Bloc

```dart
group('AuthBloc', () {
  test('emits [AuthLoading, AuthSuccess] when login succeeds', () async {
    final mockRepository = MockAuthRepository();
    when(mockRepository.signIn(
      email: 'test@example.com',
      password: 'password',
    )).thenAnswer((_) async => testUser);

    final bloc = AuthBloc(authRepository: mockRepository);

    expect(
      bloc.stream,
      emitsInOrder([
        AuthLoading(),
        isA<AuthSuccess>(),
      ]),
    );

    bloc.add(LoginRequested(email: 'test@example.com', password: 'password'));
  });
});
```

## Project Structure

Create blocs under `lib/blocs/` with subdirectories for each feature:
```
lib/blocs/
  auth/
    auth_event.dart
    auth_state.dart
    auth_bloc.dart
  user/
    user_event.dart
    user_state.dart
    user_bloc.dart
  quiz/
    ...
  room/
    ...
```

## Next Steps

1. Run `flutter pub get` to download flutter_bloc and equatable.
2. Create Bloc classes for Auth, User, Quiz, Room (TASK-024).
3. Wrap MyApp with BlocProvider(s) in main.dart.
4. Convert screens to BlocBuilder/BlocListener consumers.

## References

- [Bloc Documentation](https://bloclibrary.dev)
- [Getting Started with Bloc](https://bloclibrary.dev/#/gettingstarted)
- [Bloc Architecture](https://bloclibrary.dev/#/architecture)

