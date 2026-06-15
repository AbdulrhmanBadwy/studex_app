import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/core/constants/firestore_collections.dart';

void main() {
  late FirebaseApp testApp;
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;

  setUpAll(() async {
    // Initialize Firebase for testing
    // This test requires Firebase Emulator to be running locally
    testApp = await Firebase.initializeApp(
      name: 'test-app-security',
      options: const FirebaseOptions(
        apiKey: 'test-api-key',
        appId: 'test-app-id',
        messagingSenderId: 'test-sender-id',
        projectId: 'demo-project',
      ),
    );

    auth = FirebaseAuth.instanceFor(app: testApp);
    firestore = FirebaseFirestore.instanceFor(app: testApp);

    // Connect to Firebase Emulator
    await auth.useAuthEmulator('localhost', 9099);
    firestore.useFirestoreEmulator('localhost', 8080);
  });

  tearDownAll(() async {
    await testApp.delete();
  });

  group('Firestore Security Rules - Users Collection', () {
    late String userAId;
    late String userBId;

    setUp(() async {
      // Create test users
      try {
        final userA = await auth.createUserWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );
        userAId = userA.user!.uid;
      } catch (e) {
        // User might already exist
        userAId = 'user-a-id';
      }

      try {
        final userB = await auth.createUserWithEmailAndPassword(
          email: 'user-b@test.com',
          password: 'Password456!',
        );
        userBId = userB.user!.uid;
      } catch (e) {
        // User might already exist
        userBId = 'user-b-id';
      }
    });

    tearDown(() async {
      // Sign out after each test
      await auth.signOut();
    });

    group('Authorized Access', () {
      test('User can read own profile', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Try to read own profile
        final doc = await firestore
            .collection(FirestoreCollections.users)
            .doc(userAId)
            .get();

        // Should succeed (may be empty initially)
        expect(doc, isNotNull);
      });

      test('User can update own profile', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Try to update own profile
        await firestore
            .collection(FirestoreCollections.users)
            .doc(userAId)
            .set({
              'name': 'User A',
              'email': 'user-a@test.com',
              'role': 'student',
            });

        // Verify update
        final doc = await firestore
            .collection(FirestoreCollections.users)
            .doc(userAId)
            .get();

        expect(doc.exists, true);
        expect(doc['name'], 'User A');
      });

      test('User can create own profile', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Create profile (set with merge)
        await firestore
            .collection(FirestoreCollections.users)
            .doc(userAId)
            .set({
              'email': 'user-a@test.com',
              'role': 'student',
            }, SetOptions(merge: true));

        // Verify creation
        final doc = await firestore
            .collection(FirestoreCollections.users)
            .doc(userAId)
            .get();

        expect(doc.exists, true);
      });
    });

    group('Unauthorized Access', () {
      test('User cannot read another user profile', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Try to read User B's profile
        expect(
          () => firestore
              .collection(FirestoreCollections.users)
              .doc(userBId)
              .get(),
          throwsA(isA<FirebaseException>()),
        );
      });

      test('User cannot update another user profile', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Try to update User B's profile
        expect(
          () => firestore
              .collection(FirestoreCollections.users)
              .doc(userBId)
              .update({'name': 'Hacked'}),
          throwsA(isA<FirebaseException>()),
        );
      });

      test('User cannot delete own profile', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Try to delete own profile
        expect(
          () => firestore
              .collection(FirestoreCollections.users)
              .doc(userAId)
              .delete(),
          throwsA(isA<FirebaseException>()),
        );
      });

      test('Unauthenticated user cannot read any profile', () async {
        // Ensure signed out
        await auth.signOut();

        // Try to read any profile
        expect(
          () => firestore
              .collection(FirestoreCollections.users)
              .doc(userAId)
              .get(),
          throwsA(isA<FirebaseException>()),
        );
      });
    });

    group('Protected Collections', () {
      test('Unauthenticated user cannot read rooms collection', () async {
        // Ensure signed out
        await auth.signOut();

        // Try to read rooms
        expect(
          () => firestore.collection(FirestoreCollections.rooms).get(),
          throwsA(isA<FirebaseException>()),
        );
      });

      test('Authenticated user cannot read rooms collection (default deny)', () async {
        // Sign in as User A
        await auth.signInWithEmailAndPassword(
          email: 'user-a@test.com',
          password: 'Password123!',
        );

        // Try to read rooms (should fail — not explicitly allowed)
        expect(
          () => firestore.collection(FirestoreCollections.rooms).get(),
          throwsA(isA<FirebaseException>()),
        );
      });
    });
  });
}
