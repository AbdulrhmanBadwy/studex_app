# Architecture Documentation

This document describes the overall architecture of the Studex Flutter application, including layer responsibilities, data flow, and design patterns.

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Layered Architecture](#layered-architecture)
3. [Data Flow](#data-flow)
4. [State Management (Bloc)](#state-management-bloc)
5. [Repository Pattern](#repository-pattern)
6. [Firebase Integration](#firebase-integration)
7. [Dependency Injection](#dependency-injection)
8. [Error Handling](#error-handling)
9. [Security Model](#security-model)
10. [Future Scalability](#future-scalability)

---

## Architecture Overview

Studex follows a **clean architecture** with clear separation of concerns. The app is organized into four layers:

```
┌─────────────────────────────────────────┐
│         UI Layer (Screens/Widgets)       │
│     - SplashScreen                      │
│     - LoginScreen                       │
│     - HomeScreen (future)               │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│    State Management (Bloc)              │
│     - AuthBloc                          │
│     - UserBloc                          │
│     - FutureBlocs (Rooms, Quizzes)      │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│    Repository Layer (Data Access)       │
│     - AuthRepository                    │
│     - UserRepository                    │
│     - RoomRepository (future)           │
│     - QuizRepository (future)           │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│      Firebase Services                  │
│     - Firebase Auth                     │
│     - Cloud Firestore                   │
│     - Firebase Storage (future)         │
│     - FCM (future)                      │
└─────────────────────────────────────────┘
```

### Key Principles

- **Separation of Concerns**: Each layer has a single responsibility
- **Dependency Injection**: Dependencies flow downward, not upward
- **Testability**: Layers are decoupled and mockable
- **Reusability**: Repositories and Blocs can be used across screens
- **Maintainability**: Clear structure makes code easy to navigate

---

## Layered Architecture

### 1. UI Layer (Presentation)

**Responsibility**: Rendering UI and handling user interactions

**Components**:
- **Screens**: Full-page widgets (e.g., `SplashScreen`, `LoginScreen`)
- **Widgets**: Reusable UI components (buttons, forms, dialogs)
- **Router**: Navigation management via `GoRouter`

**Key Files**:
```
lib/features/
├── auth/
│   ├── splash_screen.dart
│   ├── login_screen.dart (future)
│   └── signup_screen.dart (future)
└── home/
    └── home_screen.dart (future)

lib/core/routes/
├── app_routes.dart (constants)
├── app_router_generation.dart (router config)
```

**Responsibilities**:
- ✅ Render widgets based on Bloc state
- ✅ Handle user input (taps, form submissions)
- ✅ Show error/success messages via Bloc listeners
- ✅ Navigate between screens
- ✅ Display loading spinners

**Does NOT**:
- ❌ Make Firebase calls directly
- ❌ Manage business logic
- ❌ Store persistent state
- ❌ Parse complex data transformations

**Example**:
```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Navigate to home
        } else if (state is AuthFailure) {
          // Show error
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return LoadingSpinner();
          }
          return LoginForm();
        },
      ),
    );
  }
}
```

---

### 2. State Management Layer (Bloc)

**Responsibility**: Managing application state and business logic

**Components**:
- **Events**: User actions or external triggers
- **States**: UI states (loading, success, failure)
- **Bloc**: Event processor that emits states

**Key Files**:
```
lib/blocs/
├── auth/
│   ├── auth_event.dart
│   ├── auth_state.dart
│   └── auth_bloc.dart
└── user/
    ├── user_event.dart
    ├── user_state.dart
    └── user_bloc.dart
```

**Bloc Types**:

#### AuthBloc
Handles authentication state and actions:

```
Events:
  - LoginRequested(email, password)
  - SignupRequested(email, password, name)
  - LogoutRequested()
  - PasswordResetRequested(email)
  - CheckAuthStatusRequested()

States:
  - AuthInitial
  - AuthLoading
  - AuthSuccess(user)
  - AuthFailure(message)
  - AuthLoggedOut
```

Flow:
```
User enters credentials
       ↓
LoginRequested event
       ↓
AuthBloc processes → calls AuthRepository.login()
       ↓
Firebase Auth response
       ↓
Emit AuthSuccess(user) or AuthFailure(error)
       ↓
UI rebuilds and navigates or shows error
```

#### UserBloc
Handles user profile state:

```
Events:
  - FetchUserRequested()
  - UpdateUserRequested(userModel)

States:
  - UserInitial
  - UserLoading
  - UserSuccess(user)
  - UserFailure(message)
```

**Bloc Lifecycle**:
```
1. Initial State: AuthInitial
2. Receive Event: LoginRequested
3. Add State: AuthLoading (optional, for loading UI)
4. Process Event: Call repository
5. Emit State: AuthSuccess or AuthFailure
6. UI Rebuilds: Bloc listeners/builders respond
```

**Key Files**:
```dart
// lib/blocs/auth/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    // Register event handlers
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        event.email,
        event.password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
```

---

### 3. Repository Layer (Data Access)

**Responsibility**: Abstracting data sources (Firebase, local cache, APIs)

**Components**:
- **Interfaces**: Define contracts for data operations
- **Implementations**: Firebase-specific logic
- **Models**: Domain models for data

**Key Files**:
```
lib/repositories/
├── auth_repository.dart (interface)
├── firebase_auth_repository.dart (implementation)
├── user_repository.dart (interface)
└── firebase_user_repository.dart (implementation)

lib/models/
├── user_model.dart
├── room_model.dart
├── quiz_model.dart
├── question_model.dart
└── quiz_attempt_model.dart
```

**Repositories**:

#### AuthRepository
```dart
abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password, String name);
  Future<void> logout();
  Future<void> resetPassword(String email);
  Stream<User?> get authStateChanges;
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;
  final UserRepository _userRepository;

  @override
  Future<UserModel> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userRepository.getCurrentUser(cred.user!.uid);
  }
}
```

#### UserRepository
```dart
abstract class UserRepository {
  Future<UserModel> getCurrentUser(String uid);
  Future<void> createUserProfile(UserModel user);
  Future<void> updateProfile(UserModel user);
}

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  @override
  Future<UserModel> getCurrentUser(String uid) async {
    final doc = await _firestore
        .collection(FirestoreCollections.users)
        .doc(uid)
        .get();
    
    if (!doc.exists) throw Exception('User not found');
    return UserModel.fromJson(doc.data()!);
  }
}
```

**Key Patterns**:

1. **Interface Segregation**: Blocs depend on interfaces, not implementations
   ```dart
   // ✅ Good: AuthBloc depends on interface
   class AuthBloc extends Bloc<AuthEvent, AuthState> {
     final AuthRepository _authRepository; // interface
   }

   // ❌ Bad: Depends on concrete class
   class AuthBloc extends Bloc<AuthEvent, AuthState> {
     final FirebaseAuthRepository _repo; // concrete
   }
   ```

2. **Error Handling**: Repositories handle Firebase exceptions
   ```dart
   Future<UserModel> login(String email, String password) async {
     try {
       final cred = await _auth.signInWithEmailAndPassword(...);
       return _userRepository.getCurrentUser(cred.user!.uid);
     } on FirebaseAuthException catch (e) {
       throw AuthException(e.code, e.message);
     }
   }
   ```

3. **Stream Support**: For real-time data
   ```dart
   @override
   Stream<User?> get authStateChanges => _auth.authStateChanges();
   ```

---

### 4. Firebase Services Layer

**Responsibility**: Backend infrastructure and data persistence

**Services**:
- **Firebase Auth**: User authentication
- **Cloud Firestore**: Document database
- **Firebase Storage**: File/image storage
- **Firebase Messaging**: Push notifications
- **Firebase Analytics**: Usage tracking

**Key Files**:
```
lib/core/config/
├── firebase_config.dart
└── app_config.dart
```

**Firebase Integration**:
```dart
// lib/core/config/firebase_config.dart
class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  runApp(const MyApp());
}
```

**Firestore Collections**:

See [Firestore Schema](firestore-schema.md) for complete details.

```
users/
  {uid}/
    - uid (string)
    - email (string)
    - name (string)
    - role (string: student|teacher|admin)
    - createdAt (timestamp)
    - updatedAt (timestamp)

rooms/
  {roomId}/
    - roomId (string)
    - name (string)
    - description (string)
    - teacherId (string)
    - members (array of userIds)
    - createdAt (timestamp)

quizzes/
  {quizId}/
    - quizId (string)
    - roomId (string)
    - title (string)
    - questions (array of questionIds)
    - createdAt (timestamp)

quiz_attempts/
  {attemptId}/
    - attemptId (string)
    - quizId (string)
    - userId (string)
    - answers (map)
    - score (number)
    - submittedAt (timestamp)
```

---

## Data Flow

### Complete Authentication Flow

```
1. User Opens App
   ↓
2. SplashScreen Loads
   ├─ Check AuthService.currentUser (synchronous)
   ├─ If user exists → Navigate to Home
   └─ If not, listen to authStateChanges stream
   ↓
3. User Taps Login Button
   ↓
4. UI Emits LoginRequested Event to AuthBloc
   ↓
5. AuthBloc Processes Event
   ├─ Emit AuthLoading state
   ├─ Call AuthRepository.login(email, password)
   ├─ AuthRepository calls Firebase Auth
   ├─ Firebase Auth returns User
   ├─ AuthRepository calls UserRepository.getCurrentUser()
   ├─ UserRepository fetches profile from Firestore
   └─ UserRepository returns UserModel
   ↓
6. AuthBloc Receives UserModel
   ├─ Emit AuthSuccess(userModel)
   └─ AuthBloc also streams to AuthService
   ↓
7. UI Listens to AuthBloc
   ├─ Receives AuthSuccess(userModel)
   ├─ BlocListener navigates to HomeScreen
   └─ HomeScreen shows user name
   ↓
8. User Profile Update
   ├─ User edits profile on screen
   ├─ UI emits UpdateUserRequested to UserBloc
   ├─ UserBloc calls UserRepository.updateProfile()
   ├─ UserRepository updates Firestore doc
   ├─ UserBloc emits UserSuccess(updatedUser)
   └─ UI rebuilds with new data
```

### Key Decision Points

**Why Bloc Listens to Firebase Stream**:
- AuthBloc listens to `AuthRepository.authStateChanges()`
- Handles external auth state changes (logout from another device)
- Keeps UI in sync with backend

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    // Listen to Firebase Auth state changes
    _authRepository.authStateChanges.listen((user) {
      if (user == null) {
        add(LogoutRequested());
      } else {
        add(CheckAuthStatusRequested());
      }
    });
  }
}
```

**Why AuthService Singleton**:
- Non-Bloc components (SplashScreen, main.dart) need auth state synchronously
- AuthService wraps AuthRepository and provides `currentUser` getter
- SplashScreen checks `AuthService.instance.currentUser` on app launch

```dart
class AuthService {
  static final AuthService _instance = AuthService._();
  
  factory AuthService.instance => _instance;
  
  AuthService._();

  UserModel? _currentUser;
  
  UserModel? get currentUser => _currentUser;
  
  Stream<UserModel?> get authStateStream => _repository.authStateChanges
      .asyncMap((user) => user == null ? null : _userRepository.getCurrentUser(user.uid));
}
```

---

## State Management (Bloc)

### Bloc Pattern

The Bloc pattern separates concerns into **Events** (inputs) and **States** (outputs):

```
User Input/Trigger
       ↓
Create Event (what user did)
       ↓
Event Added to Bloc
       ↓
Bloc.on<EventType>() handler processes event
       ↓
Call Repository (Firebase)
       ↓
Emit State (loading, success, failure)
       ↓
UI Listens and Rebuilds
       ↓
UI Actions (show message, navigate, update)
```

### Bloc Widget Integration

#### BlocBuilder
For UI rendering based on state:

```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return LoadingSpinner();
    } else if (state is AuthSuccess) {
      return HomeScreen(user: state.user);
    } else if (state is AuthFailure) {
      return LoginForm(error: state.message);
    }
    return LoginForm();
  },
)
```

#### BlocListener
For side effects (navigation, showing alerts):

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccess) {
      Navigator.pushNamed(context, Routes.home);
    } else if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: LoginForm(),
)
```

#### BlocConsumer
Combines BlocBuilder + BlocListener:

```dart
BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    // Handle side effects
  },
  builder: (context, state) {
    // Build UI
  },
)
```

### Bloc Providers

Global providers for Blocs:

```dart
// lib/main.dart
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository)
            ..add(CheckAuthStatusRequested()),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```

---

## Repository Pattern

### Why Use Repositories?

1. **Abstraction**: Hide Firebase complexity from Bloc
2. **Testability**: Mock repositories in unit tests
3. **Flexibility**: Swap Firebase for another backend
4. **Single Responsibility**: Data access logic in one place

### Repository Interface Design

```dart
// Define contract
abstract class UserRepository {
  Future<UserModel> getCurrentUser(String uid);
  Future<void> createUserProfile(UserModel user);
  Future<void> updateProfile(UserModel user);
  Stream<UserModel> watchUserProfile(String uid);
}

// Implement for Firebase
class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  @override
  Future<UserModel> getCurrentUser(String uid) async {
    final doc = await _firestore
        .collection(FirestoreCollections.users)
        .doc(uid)
        .get();
    
    if (!doc.exists) throw UserNotFoundException();
    return UserModel.fromJson(doc.data()!);
  }
}

// Use in Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository) : super(UserInitial()) {
    on<FetchUserRequested>(_onFetchUserRequested);
  }

  Future<void> _onFetchUserRequested(
    FetchUserRequested event,
    Emitter<UserState> emit,
  ) async {
    try {
      final user = await _repository.getCurrentUser(event.uid);
      emit(UserSuccess(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}

// In tests, mock repository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('UserBloc', () {
    test('emits [UserLoading, UserSuccess] when fetch succeeds', () {
      final mockRepository = MockUserRepository();
      when(mockRepository.getCurrentUser(any))
          .thenAnswer((_) async => userModel);

      final bloc = UserBloc(mockRepository);
      
      expect(
        bloc.stream,
        emitsInOrder([UserSuccess(userModel)]),
      );

      bloc.add(FetchUserRequested('uid'));
    });
  });
}
```

---

## Dependency Injection

### Current Approach

Dependencies are injected at app startup:

```dart
// lib/main.dart
void main() {
  // Initialize Firebase
  await FirebaseConfig.initialize();

  // Create repositories
  final authRepository = FirebaseAuthRepository(
    FirebaseAuth.instance,
    FirebaseUserRepository(FirebaseFirestore.instance),
  );
  
  final userRepository = FirebaseUserRepository(
    FirebaseFirestore.instance,
  );

  // Create Blocs
  final authBloc = AuthBloc(authRepository);
  final userBloc = UserBloc(userRepository);

  // Provide to app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authBloc),
        BlocProvider(create: (_) => userBloc),
      ],
      child: const MyApp(),
    ),
  );
}
```

### Future: GetIt Service Locator

For larger apps, use GetIt for centralized dependency management:

```dart
// lib/core/services/service_locator.dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  // Firebase services
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Repositories
  getIt.registerSingleton<UserRepository>(
    FirebaseUserRepository(getIt<FirebaseFirestore>()),
  );
  getIt.registerSingleton<AuthRepository>(
    FirebaseAuthRepository(
      getIt<FirebaseAuth>(),
      getIt<UserRepository>(),
    ),
  );

  // Blocs
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(getIt<AuthRepository>()),
  );
}

// lib/main.dart
void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

// In code
final authBloc = getIt<AuthBloc>();
```

---

## Error Handling

### Error Flow

```
Firebase Error
       ↓
Repository catches & converts to custom exception
       ↓
Bloc catches & emits FailureState with message
       ↓
UI listens to FailureState
       ↓
UI shows error message/dialog to user
```

### Custom Exceptions

```dart
// lib/core/exceptions/auth_exception.dart
class AuthException implements Exception {
  final String code;
  final String message;

  AuthException(this.code, this.message);

  @override
  String toString() => message;
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException([this.message = 'User not found']);

  @override
  String toString() => message;
}

// lib/repositories/firebase_auth_repository.dart
Future<UserModel> login(String email, String password) async {
  try {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userRepository.getCurrentUser(cred.user!.uid);
  } on FirebaseAuthException catch (e) {
    throw AuthException(e.code, _getAuthErrorMessage(e.code));
  } on FirebaseException catch (e) {
    throw AuthException('firebase-error', e.message ?? 'Unknown error');
  } catch (e) {
    throw AuthException('unknown-error', 'An unexpected error occurred');
  }
}

String _getAuthErrorMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Invalid email address';
    case 'user-disabled':
      return 'User account is disabled';
    case 'user-not-found':
      return 'User account not found';
    case 'wrong-password':
      return 'Incorrect password';
    default:
      return 'Authentication failed';
  }
}

// lib/blocs/auth/auth_bloc.dart
Future<void> _onLoginRequested(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final user = await _authRepository.login(
      event.email,
      event.password,
    );
    emit(AuthSuccess(user));
  } on AuthException catch (e) {
    emit(AuthFailure(e.message));
  } catch (e) {
    emit(AuthFailure('Login failed'));
  }
}
```

### Error Prevention

**Null Safety**:
```dart
// ✅ Good: explicit null checks
if (user?.uid != null) {
  await firestore.collection('users').doc(user!.uid).set(...);
}

// ✅ Better: use null-coalescing
final userId = user?.uid ?? throw UserNotFoundException();
```

**Validation**:
```dart
Future<UserModel> createUserProfile(UserModel user) async {
  // Validate input
  if (user.email.isEmpty) {
    throw ValidationException('Email cannot be empty');
  }
  if (!user.email.contains('@')) {
    throw ValidationException('Invalid email format');
  }
  
  // Proceed with Firebase write
  await _firestore.collection(FirestoreCollections.users)
      .doc(user.uid)
      .set(user.toJson());
  
  return user;
}
```

---

## Security Model

### Firestore Security Rules

Rules enforce data access at the database level:

```
users/{userId}
  ├─ read: allowed if request.auth.uid == userId
  ├─ write: allowed if request.auth.uid == userId
  └─ delete: denied (always)

rooms/{roomId}
  └─ all operations: denied by default

quizzes/{quizId}
  └─ all operations: denied by default
```

See [Firestore Security Rules](firestore-security-rules.md) for complete rules and deployment.

### Authentication Security

- ✅ Passwords hashed by Firebase Auth (bcrypt)
- ✅ Tokens automatically refreshed by Firebase SDK
- ✅ Session management handled by Firebase
- ✅ No tokens stored locally (handled by SDK)

### Data Privacy

- ✅ User can only read/update own profile
- ✅ Other users cannot access any user data
- ✅ Delete operation is blocked at database level
- ✅ Firestore rules enforce all access control

---

## Future Scalability

### As Features Expand (Phase 1+)

#### New Blocs
```
lib/blocs/
├── auth/
├── user/
├── room/          ← New
├── quiz/          ← New
├── quiz_attempt/  ← New
└── notification/  ← New
```

#### New Repositories
```
lib/repositories/
├── auth_repository.dart
├── user_repository.dart
├── room_repository.dart       ← New
├── quiz_repository.dart       ← New
├── quiz_attempt_repository.dart ← New
└── notification_repository.dart ← New
```

#### New Models
```
lib/models/
├── user_model.dart
├── room_model.dart (exists)
├── quiz_model.dart (exists)
├── question_model.dart (exists)
├── quiz_attempt_model.dart (exists)
└── notification_model.dart    ← New
```

#### New Features
```
lib/features/
├── auth/
├── home/          ← New
├── rooms/         ← New
├── quizzes/       ← New
├── notifications/ ← New
└── leaderboard/   ← New
```

### Performance Optimization

#### Pagination
```dart
Future<List<Quiz>> getQuizzes(String roomId, {int page = 0}) async {
  const pageSize = 10;
  final startAt = page * pageSize;
  
  return await _firestore
      .collection(FirestoreCollections.quizzes)
      .where('roomId', isEqualTo: roomId)
      .limit(pageSize)
      .offset(startAt)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => QuizModel.fromJson(doc.data()))
          .toList());
}
```

#### Caching with Riverpod (future alternative)
```dart
final userProvider = FutureProvider<UserModel>((ref) async {
  return ref.watch(userRepositoryProvider).getCurrentUser(uid);
});
```

#### Lazy Loading
```dart
class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(this._roomRepository) : super(RoomInitial()) {
    on<LoadMoreQuizzesRequested>(_onLoadMoreQuizzesRequested);
  }

  int _page = 0;
  
  Future<void> _onLoadMoreQuizzesRequested(
    LoadMoreQuizzesRequested event,
    Emitter<RoomState> emit,
  ) async {
    if (state is! RoomSuccess) return;
    
    try {
      final currentQuizzes = (state as RoomSuccess).quizzes;
      final newQuizzes = await _roomRepository.getQuizzes(
        event.roomId,
        page: ++_page,
      );
      
      emit(RoomSuccess(currentQuizzes + newQuizzes));
    } catch (e) {
      emit(RoomFailure(e.toString()));
    }
  }
}
```

### Multi-Tenant Support (future)

For multi-organization deployments:

```dart
// Add organization context to repositories
class RoomRepository {
  final String organizationId;
  
  Future<List<Room>> getRooms() {
    return _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('rooms')
        .get();
  }
}

// Pass org context through Bloc
class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(this._repository, this._organizationId) : super(RoomInitial());
  
  final String _organizationId;
}
```

---

## Testing Strategy

### Unit Tests
Test models, repositories, and Bloc logic:

```bash
flutter test test/models/
flutter test test/repositories/
flutter test test/blocs/
```

### Widget Tests
Test UI components and interactions:

```bash
flutter test test/widgets/
```

### Integration Tests
Test complete user flows:

```bash
flutter test integration_test/
```

### Security Tests
Test Firestore rules:

```bash
firebase emulators:start
flutter test test/security/
```

---

## Summary

| Layer | Responsibility | Examples |
|-------|---|---|
| **UI** | Rendering & user interaction | Screens, widgets, navigation |
| **Bloc** | Business logic & state management | AuthBloc, UserBloc |
| **Repository** | Data access abstraction | AuthRepository, UserRepository |
| **Firebase** | Backend persistence | Auth, Firestore, Storage |

**Key Patterns**:
- ✅ Clean architecture with clear layer separation
- ✅ Bloc pattern for state management
- ✅ Repository pattern for data access
- ✅ Dependency injection for testability
- ✅ Custom exceptions for error handling
- ✅ Firestore rules for security enforcement

This architecture supports rapid feature development while maintaining code quality and security.
