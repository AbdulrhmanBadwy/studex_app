# Studex — Collaborative Study & Assessment Platform

**Studex** is a cross-platform mobile application built with Flutter and Firebase that helps students organize collaborative study groups, communicate in real time, and assess their learning through quizzes — while giving teachers and admins tools to monitor performance.

## Core Features

- **Authentication & Roles** — Email/password and Google Sign-In, with role-based access for students, teachers, and admins, plus password recovery and profile editing.
- **Study Rooms** — Users can create public or private study rooms, join existing ones, and collaborate with peers around shared topics.
- **Real-Time Group Chat** — Each study room includes a live chat powered by Cloud Firestore streams, so members can discuss and coordinate instantly.
- **Quiz System** — A full quiz workflow tied to study rooms: multi-step quiz creation (with configurable per-question timing), a guided quiz-taking experience with live progress tracking, automatic scoring, and a results/leaderboard screen to compare performance with peers.
- **Performance Monitoring Dashboard** — A dedicated panel (for teachers/admins) presenting exam grades, performance charts, and recent activity, giving a clear view of student progress.
- **Onboarding & Localization** — A guided onboarding flow for first-time users, with full bilingual support (Arabic and English, RTL-ready) via Flutter's localization framework.
- **Offline-Aware Experience** — Firestore persistence is enabled, and a dedicated "no internet" state keeps the app usable and informative when connectivity drops.

## Technical Highlights

- **Architecture**: Clean Architecture principles applied to core modules (quiz feature separated into domain / data / presentation layers with entities, use cases, and repositories), keeping business logic independent of UI and data sources.
- **State Management**: BLoC/Cubit pattern (`flutter_bloc`) throughout, for predictable, testable state transitions across auth, chat, quizzes, and user data.
- **Dependency Injection**: Centralized service registration via `get_it`.
- **Navigation**: Declarative, type-safe routing with `go_router`.
- **Backend**: Firebase (Authentication, Cloud Firestore for real-time data, and Google Sign-In integration).
- **Responsive UI**: Adaptive layouts via `flutter_screenutil`, custom theming, and Google Fonts for consistent, polished visuals across screen sizes.

## Tech Stack

Flutter · Dart · Firebase (Auth, Firestore) · BLoC/Cubit · GetIt · GoRouter · Clean Architecture
