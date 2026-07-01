<div align="center">

# 📚 Studex

**A collaborative study companion for students — real-time rooms, group chat, and quizzes, with performance monitoring for teachers.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![State Management](https://img.shields.io/badge/State-BLoC%20%2F%20Cubit-blueviolet)](https://bloclibrary.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](#license)

</div>

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screens & Navigation](#screens--navigation)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Data Model (Firestore)](#data-model-firestore)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Current State & Known Limitations](#current-state--known-limitations)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

**Studex** is a cross-platform mobile app (Flutter) that helps students study together and helps teachers keep track of progress. Students join or create **study rooms**, chat with roommates in real time, and take **quizzes** created inside those rooms. Results feed into a **leaderboard** and a **monitoring dashboard** so both peers and teachers can see how everyone is doing.

The app is built on **Firebase** (Authentication + Cloud Firestore) for its backend, uses the **BLoC/Cubit** pattern for state management, and is being progressively migrated to a **Clean Architecture** structure on a feature-by-feature basis (the Quiz module is fully migrated; see [Architecture](#architecture)).

The app ships with full **Arabic/English localization** (Arabic is the default locale) and a responsive layout built with `flutter_screenutil`.

> This README documents the app based on the `lib/` source tree. Platform folders (`android/`, `ios/`), `pubspec.yaml`, and asset files are not included in this excerpt — see [Getting Started](#getting-started) for what you'll need to add to run the project.

---

## Features

### 🔐 Authentication & User Roles
- Email/password sign-up and login, plus **Google Sign-In**.
- Password recovery flow (`re_password`).
- Three user roles baked into the data model: `student`, `teacher`, `admin` (`UserRoles`).
- Session state exposed as a broadcast stream via `AuthService`, and managed app-wide with `AuthBloc`.
- Editable user profile (name, etc.) via a dedicated Edit Profile screen.

### 🏠 Onboarding & Home
- Three-step onboarding carousel for first-time users.
- Splash screen that routes based on auth state.
- Home dashboard with a header, quick "main task" card, and a grid of the user's recent/available study rooms.
- Persistent bottom navigation (Home · Rooms · Monitoring · Settings) implemented with `StatefulShellRoute.indexedStack`, so each tab keeps its own navigation stack.

### 🧑‍🤝‍🧑 Study Rooms
- Create **public or private** rooms with a name and description.
- Browse and join rooms from a rooms list screen.
- Each room tracks its members and each member's join timestamp.

### 💬 Real-Time Chat
- Per-room group chat backed by **Cloud Firestore streams** — messages appear live for all members.
- Chat bubble UI distinguishing sender/receiver, plus a message input field.
- Message deletion is modeled in the repository but not yet wired to the UI (see [Known Limitations](#current-state--known-limitations)).

### 📝 Quiz Engine
The most fully-featured module in the app, built with a complete Clean Architecture stack:
- **Create Quiz** — two-step creation flow (title/description, then add questions with multiple-choice options and a correct-answer index), scoped to a specific room.
- **Quiz List** — browse quizzes available in a room.
- **Take Quiz** — guided quiz-taking screen with a progress indicator and per-question flow.
- **Start Quiz** — a pre-quiz details/instructions screen before attempting.
- **Quiz Results** — automatic scoring against submitted answers, with a results screen.
- **Leaderboard** — compare scores with other room members.
- Configurable **time per question**, enforced at the quiz level.

### 📊 Monitoring Dashboard
- A dedicated panel (`MonitoringPanelScreen`) presenting:
  - A dashboard items overview section
  - Exam grades section
  - A performance chart section
  - A recent activity section
- Intended for tracking student performance over time (currently UI-first; see limitations below).

### ⚙️ Settings
- Central settings screen (profile shortcut, notifications toggle item, language item, help/privacy entries).
- Sign-out ("exit") action.
- Several settings entries are currently placeholders pending their destination screens (language selection, help center, privacy policy — see [Known Limitations](#current-state--known-limitations)).

### 🌍 Localization & Responsive UI
- Full **Arabic (default) and English** locale support via `flutter_localizations`.
- Responsive sizing across devices using `flutter_screenutil` (base design size 390×884).
- Centralized design system: `AppColors`, `AppStyles`, `AppThemes`, and Google Fonts typography.

### 📡 Offline Awareness
- Firestore **offline persistence** enabled at startup.
- Dedicated `NoInternetScreen` route (`/no_internet`) for connectivity loss.

---

## Screens & Navigation

Routing is centralized in `AppRoutes` (route name constants) and wired up in `app_router_generation.dart` using **go_router**, including a `StatefulShellRoute` for the persistent bottom tab bar.

| Route | Screen | Notes |
|---|---|---|
| `/on_boarding1_screen`, `2`, `3` | Onboarding | First-run carousel |
| `/splash_screen` | Splash | Auth-state routing gate |
| `/login_Screen` | Login | Email/password + Google |
| `/register_Screen` | Register | New account |
| `/re_password_screen` | Re-password | Password reset |
| `/home_screen` *(tab)* | Home | Recent rooms, quick actions |
| `/room_list_screen` *(tab)* | Rooms List | Browse/join rooms |
| `/monitoring_panel_screen` *(tab)* | Monitoring Dashboard | Grades & performance |
| `/settings_Screen` *(tab)* | Settings | Profile, preferences, sign-out |
| `/create_room_screen` | Create Room | New public/private room |
| `/room_chat_screen` | Room Chat | Real-time group chat |
| `/quiz_list_screen` | Quiz List | Quizzes within a room |
| `/create_quiz_step_one`, `/create_quizz`, `/create_quiz_step_two` | Create Quiz Flow | Multi-step quiz builder |
| `/start_quiz` | Start Quiz | Pre-attempt instructions |
| `/take_quiz` | Take Quiz | Timed question flow |
| `/quiz_result_screen` | Quiz Result | Scoring & review |
| `/leaderboard_Screen` | Leaderboard | Room ranking |
| `/edit_profile_Screen` | Edit Profile | Update user info |
| `/no_internet` | No Internet | Connectivity fallback |

---

## Architecture

Studex uses a **hybrid architecture** that reflects its evolution as a graduation project — this is worth understanding before contributing:

- **Quiz feature → full Clean Architecture.** `lib/features/quiz/` is split into `data/` (models, remote data source, repository implementation), `domain/` (entities, repository interface, use cases), and `presentation/` (Cubits, screens, widgets). Business logic (e.g. `CreateQuizUseCase`, `GetQuizzes`, `SubmitQuizAnswers`) is decoupled from Firestore-specific code, and dependencies are wired through `get_it` in `injection_container.dart`.
- **Other features (Auth, User, Rooms, Chat) → simple repository pattern.** These use a flatter structure: a repository directly under `lib/repositories/` (e.g. `FirebaseAuthRepository`, `FirestoreUserRepository`) consumed straight from a Bloc/Cubit, without a separate domain layer. This is simpler but tightly coupled to Firestore.

**State management** is consistent across the app regardless of layer depth: every feature exposes its state through **BLoC or Cubit** (`flutter_bloc`), with immutable state classes and typed events where applicable (see `blocs/auth`, `blocs/user`, and the various feature-level cubits).

**Navigation** is fully declarative via **go_router**, with a `StatefulShellRoute` preserving independent navigation stacks per bottom-tab.

**Dependency injection** is partial: the Quiz feature's use cases, repository, and cubits are registered in a global `GetIt` instance (`sl`); other features currently construct their repositories directly in `main.dart` or inline.

```
Presentation (Screens / Widgets / Cubit-Bloc)
        │
        ▼
   Domain (Entities, Use Cases, Repository Interfaces)   ← Quiz only
        │
        ▼
     Data (Models, Remote Data Source, Repository Impl)
        │
        ▼
      Firebase (Auth, Firestore)
```

---

## Tech Stack

| Category | Choice |
|---|---|
| Framework | Flutter / Dart |
| Backend | Firebase Authentication, Cloud Firestore |
| Auth Providers | Email/Password, Google Sign-In |
| State Management | `flutter_bloc` (Bloc + Cubit) |
| Navigation | `go_router` (incl. `StatefulShellRoute`) |
| Dependency Injection | `get_it` |
| Responsive UI | `flutter_screenutil` |
| Typography | `google_fonts` |
| Vector Assets | `flutter_svg` |
| Local Storage | `shared_preferences` |
| Localization | `flutter_localizations` (`intl`), Arabic + English |
| Utilities | `uuid`, `equatable`, `meta` |

> Exact package versions live in `pubspec.yaml`, which wasn't included in this source excerpt — check that file in the repo root for pinned versions.

---

## Data Model (Firestore)

Collections are centralized in `FirestoreCollections` to avoid hardcoded strings:

| Collection | Purpose | Backing Model |
|---|---|---|
| `users` | User profiles & roles | `UserModel` (`uid`, `email`, `name`, `role`) |
| `rooms` | Study rooms | `RoomModel` (`id`, `name`, `description`, `type`, `creatorId`, `members`, `memberJoinedAt`, last-message metadata) |
| `quizzes` | Quizzes per room | `QuizEntity` / `QuizModel` (`id`, `title`, `description`, `roomId`, `questions`, `resultsCount`, `timePerQuestion`) |
| `quiz_attempts` | Submitted quiz results | `QuizResultEntity` |
| `notifications` | Reserved for future notification records | — *(collection name defined, not yet populated by any service)* |

Room chat messages are stored as a subcollection keyed by room, modeled by `MessageModel` (`id`, `senderId`, `senderName`, `message`, `createdAt`).

---

## Project Structure

```
lib/
├── blocs/                    # App-wide Blocs (not tied to one feature)
│   ├── auth/                 # AuthBloc, AuthEvent, AuthState
│   └── user/                 # UserBloc, UserEvent, UserState
├── core/
│   ├── config/                # AppConfig, EnvironmentConfig, FirebaseConfig
│   ├── constants/              # Routes-safe constants: roles, collections, fonts, asset paths
│   ├── di/                    # GetIt injection container (Quiz feature)
│   ├── routes/                 # AppRoutes + go_router configuration
│   ├── services/               # AuthService (session stream)
│   ├── theme/                  # AppColors, AppStyles, AppThemes
│   └── widgets/                # Shared widgets (NoInternetScreen, Spacing)
├── features/
│   ├── auth/                   # Login, Register, Re-password, Splash
│   ├── chat/                   # presentation/{cubits,screens,widgets}
│   ├── homescreen/              # Home tab + cubit + widgets
│   ├── monitoringPanel/          # Dashboard tab + widgets
│   ├── onboarding/               # 3-step onboarding
│   ├── quiz/                     # Full Clean Architecture module
│   │   ├── data/                  # models, data_source, repositories (impl)
│   │   ├── domain/                 # entities, repositres (interfaces), use_cases
│   │   └── presentation/            # cubits, screens, widgets
│   ├── rooms/                     # Create Room, Rooms List + widgets
│   ├── settings/                   # Settings + Edit Profile
│   └── widgets/                     # Shared cross-feature widgets/buttons
├── models/                     # Legacy/shared models (used outside the Quiz module)
├── repositories/                # Simple repositories: auth, user, room, chat, (quiz*)
├── services/                    # Placeholder services (see Known Limitations)
├── firebase_options.dart        # FlutterFire-generated platform config
└── main.dart                    # App bootstrap & providers
```

*(`repositories/quiz_repository.dart` is legacy and superseded by `features/quiz/domain/repositres/quiz_repository.dart` — kept for reference during the migration.)*

---

## Getting Started

> **Note:** This excerpt includes only the `lib/` directory. To run the project you'll need the rest of a standard Flutter project (`pubspec.yaml`, `android/`, `ios/`, `assets/`) and your own Firebase project.

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- A [Firebase](https://console.firebase.google.com) project with **Authentication** (Email/Password + Google) and **Cloud Firestore** enabled
- [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) for generating `firebase_options.dart`

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/<your-org>/studex.git
cd studex

# 2. Install dependencies
flutter pub get

# 3. Connect your Firebase project (regenerates firebase_options.dart)
flutterfire configure

# 4. Run the app
flutter run
```

### Environment
The app reads a build-time `ENV` flag (`development` by default):

```bash
flutter run --dart-define=ENV=staging
```

### Firestore Security Rules
Since the app relies on client-side Firestore reads/writes (rooms, messages, quizzes, attempts), make sure to configure Firestore Security Rules for your project before going to production — none are included in this excerpt.

---

## Current State & Known Limitations

This reflects the project's state as of this codebase snapshot, to set accurate expectations for anyone picking it up:

- **Empty service placeholders** — `services/firebase_service.dart`, `services/notification_service.dart`, and `services/storage_service.dart` exist as empty files. Notifications and file/image storage (e.g. profile avatars) are **not yet implemented**, even though the `notifications` Firestore collection and a notification item widget already exist in the UI.
- **Avatar upload** — the Edit Profile screen has a placeholder for an avatar/image picker flow; it isn't wired up yet.
- **Settings destinations** — the Language selection, Help Center, and Privacy Policy items in Settings are visible but don't yet navigate anywhere.
- **Notifications entry point** — the bell icon on the Monitoring dashboard app bar doesn't yet route to a notifications screen.
- **Chat message deletion** — `deleteMessage` is defined on `ChatRepository` but not implemented.
- **Architecture migration in progress** — only the Quiz feature has been moved to Clean Architecture (domain/data/presentation with use cases). Auth, Users, Rooms, and Chat still use direct repository access from Blocs/Cubits. If contributing, consider following the Quiz module's pattern for new features.
- **No automated tests** included in this excerpt (`test/` directory not present).
- **No CI/CD configuration** included.

---

## Roadmap

- [ ] Implement push notifications (service + UI wiring to the existing `notifications` collection)
- [ ] Profile avatar upload via `storage_service.dart`
- [ ] In-app language switcher
- [ ] Help Center and Privacy Policy content
- [ ] Chat message deletion & editing
- [ ] Migrate Auth, User, Rooms, and Chat features to the Clean Architecture pattern established by Quiz
- [ ] Firestore Security Rules and role-based access enforcement (student vs. teacher vs. admin)
- [ ] Automated test coverage (unit tests for use cases/Cubits, widget tests for key screens)

---

## Contributing

Contributions are welcome. If you're adding a new feature, please follow the Clean Architecture pattern used in `lib/features/quiz/` (entities → use cases → repository interface/implementation → Cubit → screens) rather than the legacy direct-repository pattern, to keep the codebase converging on one architecture.

1. Fork the repo and create a feature branch
2. Keep Firestore collection names in `FirestoreCollections` and routes in `AppRoutes` — avoid hardcoded strings
3. Open a pull request describing the change and any Firestore schema impact

---

## License

This project is licensed under the MIT License — see the `LICENSE` file for details. *(Add a `LICENSE` file to the repo root if one isn't present yet.)*

---

<div align="center">
Built with Flutter & Firebase — a graduation project focused on collaborative studying.
</div>
