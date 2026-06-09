import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getCurrentUser(String uid);
  Future<void> createUserProfile(UserModel user);
  Future<void> updateProfile(UserModel user);
}

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  FirestoreUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  @override
  Future<UserModel?> getCurrentUser(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> createUserProfile(UserModel user) async {
    await _usersCollection.doc(user.uid).set(user.toJson());
  }

  @override
  Future<void> updateProfile(UserModel user) async {
    await _usersCollection.doc(user.uid).update(user.toJson());
  }
}
