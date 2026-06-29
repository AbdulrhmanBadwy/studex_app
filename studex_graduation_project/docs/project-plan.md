# Phase 0 — Project Foundation

**Owner:** Single Developer

**Estimated Duration:** 4–7 Days

## Objective

The goal of this phase is to establish a solid and scalable foundation before implementing any business features such as Rooms, Quizzes, Dashboard, Notifications, or Leaderboards.

At the end of this phase, the project should have:

* Firebase fully integrated
* Authentication infrastructure ready
* Firestore schema finalized
* Domain models standardized
* Repository architecture established
* State management configured
* Security rules initialized
* Documentation prepared for team collaboration

---

# Epic 1 — Firebase Integration

## TASK-001 — Create Firebase Project

### Description

Create and configure the Firebase project that will serve as the backend for the application.

### Checklist

* Create Firebase Project
* Register Android Application
* Register iOS Application (Optional)
* Enable Firebase Analytics

### Definition of Done

* Firebase project is accessible to the team
* Android app is successfully connected
* Analytics is enabled

---

## TASK-002 — Configure Flutter Firebase

### Description

Integrate Firebase SDK into the Flutter project.

### Checklist

* Run FlutterFire configuration
* Generate `firebase_options.dart`
* Add required Firebase packages

### Dependencies

```yaml
firebase_core
firebase_auth
cloud_firestore
firebase_storage
firebase_messaging
```

### Definition of Done

* Firebase initializes successfully
* Application launches without Firebase-related errors

---

## TASK-003 — Environment Configuration

### Description

Centralize all environment and configuration settings.

### Create Directory

```text
lib/core/config/
```

### Create Files

```text
app_config.dart
firebase_config.dart
environment.dart
```

### Definition of Done

* No Firebase configuration values are hardcoded inside UI screens
* Configuration is managed from a single location

---

# Epic 2 — Architecture Refactoring

## TASK-004 — Implement Feature-Based Structure

### Description

Refactor project structure into a scalable architecture.

### Target Structure

```text
lib/

core/
features/
repositories/
services/
models/
```

### Definition of Done

* All files are organized according to the new structure
* No legacy folder structure remains

---

## TASK-005 — Create Repository Layer

### Description

Introduce repository abstraction between UI and data sources.

### Create Repositories

```text
AuthRepository
UserRepository
RoomRepository
QuizRepository
```

### Definition of Done

* Repository classes exist
* Repository interfaces are clearly defined

---

## TASK-006 — Remove Business Logic From UI

### Description

UI should only be responsible for presentation.

### Rules

The following should never appear directly inside UI screens:

```dart
FirebaseFirestore.instance
FirebaseAuth.instance
FirebaseStorage.instance
```

### Definition of Done

* All Firebase calls are moved into repositories or services
* Screens communicate only through repositories/providers

---

# Epic 3 — Firestore Database Design

## TASK-007 — Define Firestore Collections

### Description

Finalize database collections before implementation begins.

### Collections

```text
users
rooms
quizzes
quiz_attempts
notifications
```

### Definition of Done

* Collections are reviewed and approved by the team

---

## TASK-008 — Create Firestore Schema Documentation

### Description

Document the complete Firestore structure.

### Create File

```text
docs/firestore-schema.md
```

### Example

```text
users
 └ uid
    ├ name
    ├ email
    ├ role
```

### Definition of Done

* Every collection and field is documented

---

## TASK-009 — Define User Roles

### Description

Establish authorization roles used throughout the application.

### Roles

```text
student
teacher
admin
```

### Definition of Done

* Role definitions documented
* Roles included in User model

---

# Epic 4 — Domain Models

## TASK-010 — UserModel

### Requirements

Implement:

```dart
fromJson();
toJson();
copyWith();
```

### Definition of Done

* Fully serializable model

---

## TASK-011 — RoomModel

### Requirements

Implement:

```dart
fromJson();
toJson();
copyWith();
```

### Definition of Done

* Fully serializable model

---

## TASK-012 — QuizModel

### Requirements

Implement:

```dart
fromJson();
toJson();
copyWith();
```

### Definition of Done

* Fully serializable model

---

## TASK-013 — QuestionModel

### Requirements

Implement:

```dart
fromJson();
toJson();
copyWith();
```

### Definition of Done

* Fully serializable model

---

## TASK-014 — QuizAttemptModel

### Requirements

Implement:

```dart
fromJson();
toJson();
copyWith();
```

### Definition of Done

* Fully serializable model

---

## TASK-015 — Unit Testing Models

### Description

Verify serialization and deserialization.

### Test Coverage

* JSON → Model
* Model → JSON
* copyWith()

### Definition of Done

* All model tests pass successfully

---

# Epic 5 — Authentication Foundation

## TASK-016 — Create AuthRepository

### Required Methods

```dart
signIn();
signUp();
signOut();
resetPassword();
```

### Definition of Done

* Repository interface completed

---

## TASK-017 — Firebase Authentication Integration

### Description

Implement actual Firebase Authentication logic.

### Definition of Done

* Login works
* Registration works
* Logout works
* Password reset works

---

## TASK-018 — Authentication State Listener

### Description

Monitor authentication status changes.

### Required Stream

```dart
Stream<User?>
```

### Definition of Done

* Auth state updates correctly across the application

---

## TASK-019 — Auto Login Flow

### Navigation Flow

```text
Splash Screen
      ↓
Check Authentication State
      ↓
Home Screen / Login Screen
```

### Definition of Done

* Users remain logged in after reopening the app

---

# Epic 6 — User Management

## TASK-020 — Create User Profile After Registration

### Description

Automatically create a Firestore user document after account creation.

### Firestore Path

```text
users/{uid}
```

### Definition of Done

* User document is generated immediately after registration

---

## TASK-021 — Get Current User Profile

### Repository Method

```dart
getCurrentUser()
```

### Definition of Done

* Current user profile is retrieved successfully

---

## TASK-022 — Update User Profile

### Repository Method

```dart
updateProfile()
```

### Definition of Done

* Profile updates persist in Firestore

---

# Epic 7 — Application State Foundation

## TASK-023 — Select State Management Solution

### Options

* Riverpod (Recommended)
* Provider
* Bloc

### Definition of Done

* Team agrees on one solution
* Documentation updated

---

## TASK-024 — Create Global Providers

### Examples

```text
authProvider
userProvider
```

### Definition of Done

* Core providers are available throughout the application

---

## TASK-025 — Remove Legacy Local State Logic

### Remove

```text
storage_service
mock users
local authentication
temporary local state
```

### Definition of Done

* No business-critical data relies on local mock storage

---

# Epic 8 — Security Foundation

## TASK-026 — Firestore Security Rules v1

### Initial Rule

Users can:

```text
Read their own profile
Update their own profile
```

### Definition of Done

* Rules deployed successfully

---

## TASK-027 — Security Testing

### Test Cases

* Unauthorized read
* Unauthorized update
* Authorized access

### Definition of Done

* Security rules validated successfully

---

# Epic 9 — Developer Documentation

## TASK-028 — Project Setup Guide

### Create

```text
README.md
```

### Include

* Installation steps
* Firebase setup
* Running the application
* Environment configuration

### Definition of Done

* New developer can run the project without assistance

---

## TASK-029 — Contribution Guide

### Create

```text
docs/contributing.md
```

### Include

* Branch naming convention
* Commit message convention
* Pull request workflow
* Code review process

### Definition of Done

* Team development workflow documented

---

## TASK-030 — Architecture Documentation

### Create

```text
docs/architecture.md
```

### Architecture Flow

```text
UI Layer
    ↓
Provider / State Management
    ↓
Repository Layer
    ↓
Firebase Services
```

### Definition of Done

* Architecture diagram and explanation completed

---

# Phase 0 Exit Criteria

The following features must NOT be implemented before this phase is completed:

* Rooms
* Quizzes
* Dashboard
* Notifications
* Leaderboard
* Monitoring System

### Phase Completion Requirements

* Firebase Integrated
* Authentication Working
* Firestore Schema Finalized
* Models Standardized
* Repository Layer Implemented
* State Management Selected
* Security Rules Configured
* Documentation Completed

Once all tasks are completed, the project is ready for parallel feature development by multiple developers.
