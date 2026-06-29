# Firestore Collections (Defined)

This file lists the canonical Firestore collection names used by the application. These names should be treated as the single source of truth and referenced from code via `FirestoreCollections` constants.

Collections

- users — Stores user profiles (path: `users/{uid}`)
- rooms — Stores room metadata and membership
- quizzes — Stores quiz definitions and metadata
- quiz_attempts — Stores users' quiz attempts and results
- notifications — Stores notifications targeted to users

Review

Please review this list. When approved by the team, these constants will be used in repositories and services across the app.
