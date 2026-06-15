# Firestore Security Rules — v1

## Overview

Initial security rules enforce basic user profile access:
- Users can **read** their own profile document
- Users can **update** their own profile document
- Users can **create** their own profile during registration
- Users **cannot delete** their own profile
- All other operations are **denied by default**

## Rules File

Location: `firestore.rules` (deploy via Firebase Console or CLI)

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection: each user can read and update their own profile
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
      allow create: if request.auth.uid == userId;
      allow delete: if false; // prevent deletion of own profile
    }

    // All other collections: deny by default
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

## Deployment Instructions

### Via Firebase CLI
```bash
firebase deploy --only firestore:rules
```

### Via Firebase Console
1. Go to Cloud Firestore → Rules
2. Copy and paste the rules from `firestore.rules`
3. Click "Publish"

## Testing the Rules

Use Firebase Emulator or Console:

**Authorized:**
- User A reading `users/{userA}` → ✅ Allowed
- User A updating `users/{userA}` → ✅ Allowed

**Unauthorized:**
- User A reading `users/{userB}` → ❌ Denied
- User A updating `users/{userB}` → ❌ Denied
- User A deleting `users/{userA}` → ❌ Denied
- Unauthenticated read `users/{userA}` → ❌ Denied

## Future Enhancements (TASK-027+)

- Add rules for rooms (owner/member access)
- Add rules for quizzes (owner/public quiz access)
- Add rules for quiz_attempts (owner access)
- Add rules for notifications (recipient access)

## Definition of Done

✅ Rules deployed successfully to Firebase Console
