# Security Testing — TASK-027

## Test Cases

### 1. Authorized Access Tests ✅

**Test: User can read own profile**
- Setup: Sign in as User A
- Action: Read `users/{userA}`
- Expected: ✅ Succeeds

**Test: User can update own profile**
- Setup: Sign in as User A
- Action: Update `users/{userA}` fields
- Expected: ✅ Succeeds

**Test: User can create own profile**
- Setup: Sign in as User A (new user)
- Action: Create `users/{userA}`
- Expected: ✅ Succeeds

### 2. Unauthorized Access Tests ✅

**Test: User cannot read another user's profile**
- Setup: Sign in as User A
- Action: Read `users/{userB}`
- Expected: ❌ Denied (FirebaseException)

**Test: User cannot update another user's profile**
- Setup: Sign in as User A
- Action: Update `users/{userB}` fields
- Expected: ❌ Denied (FirebaseException)

**Test: User cannot delete own profile**
- Setup: Sign in as User A
- Action: Delete `users/{userA}`
- Expected: ❌ Denied (FirebaseException)

**Test: Unauthenticated user cannot read any profile**
- Setup: Not signed in
- Action: Read any `users/{userId}`
- Expected: ❌ Denied (FirebaseException)

## Running the Tests

### Prerequisites
1. **Start Firebase Emulator:**
   ```bash
   firebase emulators:start
   ```

2. **Create Test Users in Auth Emulator:**
   - user1@test.com / password123
   - user2@test.com / password456

3. **Set Emulator Host (if needed):**
   ```bash
   export FIRESTORE_EMULATOR_HOST=localhost:8080
   export FIREBASE_AUTH_EMULATOR_HOST=localhost:9099
   ```

### Run Tests
```bash
flutter test test/security/firestore_security_test.dart
```

## Manual Testing via Firebase Console

1. Open [Firebase Console](https://console.firebase.google.com)
2. Navigate to Cloud Firestore
3. Click "Rules" tab
4. Use the "Simulator" to test rules:
   - Set Auth: `{ "uid": "user-a" }`
   - Request: `read` `users/user-a` → ✅ Allow
   - Request: `read` `users/user-b` → ❌ Deny
   - Request: `delete` `users/user-a` → ❌ Deny

## Definition of Done

✅ Security rules validated successfully
- Authorized access working
- Unauthorized access blocked
- All test cases passing
