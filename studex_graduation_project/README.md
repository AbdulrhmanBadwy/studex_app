# Studex – Educational App Platform

A Flutter-based educational application platform built with **Firebase** backend, featuring real-time authentication, Firestore database, and **Bloc-based state management**.

**Phase:** Foundation (Phase 0) - Establishing core infrastructure for authentication, state management, and security.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Firebase Setup](#firebase-setup)
5. [Running the Application](#running-the-application)
6. [Project Structure](#project-structure)
7. [Documentation](#documentation)
8. [Troubleshooting](#troubleshooting)

---

## Project Overview

**Studex** is an educational platform that connects teachers and students in collaborative learning environments. Phase 0 focuses on establishing:

- ✅ **Authentication**: Firebase Auth with email/password registration and login
- ✅ **State Management**: Flutter Bloc for global auth and user state
- ✅ **Database Schema**: Firestore collections for users, rooms, quizzes, questions, and attempts
- ✅ **Security**: Firestore rules enforcing user privacy and data access control
- ✅ **Domain Models**: Fully serializable Dart models with copyWith() support

### Tech Stack

| Component | Technology |
|-----------|-----------|
| UI Framework | Flutter 3.9.2+ |
| State Management | Flutter Bloc 8.1.3 |
| Backend | Firebase |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| Storage | Firebase Storage |
| Push Notifications | Firebase Cloud Messaging |
| Routing | GoRouter 17.1.0 |

---

## Prerequisites

Before setting up, ensure you have:

- **Flutter SDK**: 3.9.2 or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: 3.9.2 or higher (included with Flutter)
- **Android Development**:
  - Android SDK API 34+
  - Android Studio or command-line tools
- **iOS Development** (optional):
  - Xcode 15+
  - iOS 13.0+
- **Firebase Account**: [Create Firebase Project](https://console.firebase.google.com)
- **Git**: For version control

### Verify Installation

```bash
flutter --version
dart --version
```

Expected output:
```
Flutter 3.9.2 or higher
Dart 3.9.2 or higher
```

---

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/AbdulrhmanBadwy/studex_app.git
cd studex_app/studex_graduation_project
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

This installs all packages listed in `pubspec.yaml`, including:
- Firebase packages (firebase_core, firebase_auth, cloud_firestore, firebase_storage, firebase_messaging)
- UI packages (flutter_screenutil, go_router, google_fonts)
- State management (flutter_bloc, equatable)

### 3. Verify Installation

```bash
flutter doctor
```

All items should show ✓ green checkmarks. Address any warnings as needed.

---

## Firebase Setup

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **"Create a project"**
3. Enter project name: `studex-app-project`
4. Enable Google Analytics (optional)
5. Click **"Create project"**

### Step 2: Register Android App

1. In Firebase Console, click **"Add App"** → **"Android"**
2. Enter package name: `com.example.studex_graduation_project`
3. Download `google-services.json`
4. Place file at: `android/app/google-services.json`

### Step 3: Register iOS App (Optional)

1. Click **"Add App"** → **"iOS"**
2. Enter iOS bundle ID: `com.example.studexGraduationProject`
3. Download `GoogleService-Info.plist`
4. Place in Xcode project

### Step 4: Enable Firebase Services

1. **Authentication**:
   - Go to **Authentication** → **Sign-in method**
   - Enable **Email/Password** provider
   - Save

2. **Cloud Firestore**:
   - Go to **Firestore Database**
   - Click **"Create Database"**
   - Start in **Test Mode** (for development)
   - Choose region (e.g., `us-central1`)
   - Click **"Create"**

3. **Firestore Security Rules** (IMPORTANT):
   - In Firestore, go to **Rules** tab
   - Copy contents from `firestore.rules` in project root
   - Paste and **"Publish"**
   - ⚠️ **Before production**: Change from Test Mode to Production rules

### Step 5: FlutterFire Configuration (Already Done)

The project includes pre-configured `lib/firebase_options.dart`. If you need to regenerate:

```bash
flutterfire configure
```

This updates Firebase configuration for your platform.

---

## Running the Application

### Android (Recommended for Development)

```bash
# Run on connected Android device or emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### iOS

```bash
# Run on iOS simulator
flutter run -d iPhone

# Run on connected device
flutter run
```

### Web (Development Only)

```bash
flutter run -d chrome
```

### Build Release APK (Android)

```bash
flutter build apk --release
```

APK location: `build/app/outputs/flutter-app-release.apk`

---

## Environment Configuration

### Configuration Files

All environment and configuration settings are centralized:

- **`lib/core/config/app_config.dart`**: Application-wide settings
- **`lib/core/config/firebase_config.dart`**: Firebase initialization
- **`lib/core/config/environment.dart`**: Environment variables (dev, test, prod)

### No Hardcoded Values

✅ **All Firebase configuration is managed centrally** — never hardcoded in UI screens.

### Default Configuration

The app initializes with:
- **Auth State Monitoring**: AuthBloc listens to Firebase Auth state changes
- **User Profile Sync**: Firestore profile data synced to UserBloc on login
- **Auto-login**: SplashScreen checks for cached user on app launch
- **Security Rules**: All requests validated against Firestore security rules

### Customization

To customize app settings, edit:

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static const String appName = 'Studex';
  static const String appVersion = '1.0.0';
  // Add custom config here
}
```

---

## Project Structure

```
studex_graduation_project/
├── lib/
│   ├── main.dart                      # App entry point (MultiBlocProvider setup)
│   ├── core/
│   │   ├── config/                    # Centralized configuration
│   │   ├── constants/                 # App-wide constants (roles, collections)
│   │   ├── routes/                    # GoRouter configuration
│   │   └── services/                  # Singletons (AuthService)
│   ├── models/                        # Domain models (User, Room, Quiz, etc.)
│   ├── repositories/                  # Data layer (Firebase integration)
│   ├── blocs/                         # State management
│   │   ├── auth/                      # Authentication state
│   │   └── user/                      # User profile state
│   └── features/                      # UI screens and widgets
│       └── auth/                      # Authentication screens
├── test/
│   ├── models/                        # Model unit tests
│   └── security/                      # Firestore security rule tests
├── docs/                              # Documentation
│   ├── project-plan.md                # Phase 0 task list
│   ├── firestore-schema.md            # Database schema
│   ├── firestore-collections.md       # Collection names
│   ├── user-roles.md                  # User roles (student, teacher, admin)
│   ├── state-management.md            # Bloc architecture
│   ├── firestore-security-rules.md    # Security rules deployment
│   └── security-testing.md            # Security test cases
├── firestore.rules                    # Firestore security rules
├── firebase.json                      # Firebase CLI configuration
└── pubspec.yaml                       # Dependencies
```

---

## Documentation

### Quick Links

| Document | Purpose |
|----------|---------|
| [Project Plan](docs/project-plan.md) | Phase 0 tasks and requirements |
| [Firestore Schema](docs/firestore-schema.md) | Database structure (5 collections) |
| [State Management](docs/state-management.md) | Bloc architecture and patterns |
| [Security Rules](docs/firestore-security-rules.md) | Firestore rules deployment |
| [User Roles](docs/user-roles.md) | Role-based access control |
| [Security Testing](docs/security-testing.md) | Security rule test cases |

### Key Concepts

#### Authentication Flow

1. **App Launch** → SplashScreen
2. **Auto-Login Check** → AuthService.currentUser (synchronous)
3. **Listen to Auth State** → authStateChanges() stream
4. **User Logged In** → Fetch profile via UserBloc → Navigate to home
5. **User Logged Out** → Navigate to login

#### State Management (Bloc)

- **AuthBloc**: Handles login, signup, logout, password reset
- **UserBloc**: Handles profile fetch and updates
- **Bloc Events**: User actions (LoginRequested, LogoutRequested, etc.)
- **Bloc States**: UI states (AuthLoading, AuthSuccess, AuthFailure, etc.)

#### Database Schema

5 Firestore collections:
1. **users** — User profiles and metadata
2. **rooms** — Collaborative learning spaces
3. **quizzes** — Quiz definitions
4. **quiz_attempts** — User quiz responses
5. **notifications** — User notifications

See [Firestore Schema](docs/firestore-schema.md) for complete field definitions.

---

## Troubleshooting

### Common Issues

#### 1. Firebase Not Initialized

**Error**: `FlutterError (Firebase.initializeApp() not called before usage)`

**Solution**:
```dart
// main.dart already has this, but verify:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

#### 2. Firestore Rules Deny Access

**Error**: `[cloud_firestore/permission-denied]`

**Solution**:
- Deploy Firestore rules from `firestore.rules`
- Go to Firebase Console → Firestore → Rules
- Paste contents of `firestore.rules` and publish
- Verify Test Mode is enabled (for development)

#### 3. Android Gradle Build Fails

**Error**: `com.android.build.gradle.internal.tasks.LintBaselineTask`

**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

#### 4. Dependency Version Conflict

**Error**: `pub get` fails with version constraints

**Solution**:
```bash
flutter pub upgrade --major-versions
flutter pub get
```

#### 5. Hot Reload Not Working

**Solution**:
```bash
# Stop running instance and restart
flutter run --no-fast-start
```

### Logs and Debugging

Enable verbose logging:

```bash
flutter run -v
```

Check device logs:

```bash
# Android
flutter logs

# iOS
flutter logs
```

---

## Testing

### Run Unit Tests

```bash
flutter test test/models/
```

All domain models have unit tests verifying serialization.

### Run Security Tests

Requires Firebase Emulator:

```bash
# Start emulator
firebase emulators:start

# In another terminal
flutter test test/security/
```

---

## Development Workflow

### Before Starting Development

1. ✅ Clone repo and install dependencies
2. ✅ Set up Firebase project and download credentials
3. ✅ Run `flutter pub get`
4. ✅ Verify `flutter doctor` shows no critical issues
5. ✅ Run app on device/emulator

### Code Standards

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` to check for linting issues
- Write unit tests for models and repositories
- Document complex business logic with comments

### Useful Commands

```bash
# Analyze code for issues
flutter analyze

# Format code
dart format lib/ test/

# Run all tests
flutter test

# Get package size info
flutter build apk --release && flutter install
```

---

## Contribution

See [Contributing Guide](docs/contributing.md) for:
- **Branch naming conventions**: `feature/*`, `bugfix/*`, `docs/*`, `test/*`
- **Commit message format**: `feat(scope): description` (Conventional Commits)
- **Pull request workflow**: Requirements and review process
- **Code standards**: Dart style guide, Bloc patterns, error handling
- **Testing requirements**: Unit, widget, and integration tests
- **Code review process**: For authors and reviewers

All contributors must follow these guidelines to maintain code quality and consistency.

---

## License

Private project — All rights reserved.

---

## Support

For questions or issues:
1. Check [Troubleshooting](#troubleshooting) section
2. Review [Documentation](#documentation) files
3. Check Firebase Console for service status

---

## Project Status

**Current Phase**: Phase 0 - Foundation ✅

- ✅ Firebase integration
- ✅ Authentication infrastructure
- ✅ Domain models (User, Room, Quiz, Question, QuizAttempt)
- ✅ Firestore schema
- ✅ Bloc state management
- ✅ Security rules (v1)
- ✅ Documentation

**Next Phase**: Phase 1 - Core Features (Rooms, Quizzes, Dashboard)
