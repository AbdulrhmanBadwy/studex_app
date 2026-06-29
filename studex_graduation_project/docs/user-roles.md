# User Roles

Canonical user roles used across the application:

- student — Default role for newly registered users. Limited privileges.
- teacher — Can create and manage quizzes, rooms, and view student attempts.
- admin — Full privileges for managing data and platform settings.

Usage

- Reference roles using `UserRoles` constants from `lib/core/constants/user_roles.dart`.
- Store role as a string in the user document (`role` field).

Recommendation

- Enforce role-based access in Firestore security rules and backend checks.
