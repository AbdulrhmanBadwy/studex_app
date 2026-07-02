import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studex_graduation_project/core/constants/firestore_collections.dart';

import '../models/room_model.dart';

abstract class RoomRepository {
  Stream<List<RoomModel>> getRooms();
  Stream<List<RoomModel>> getUserRooms(String userId);
  Future<RoomModel> createRoom(RoomModel room);
  Future<void> joinRoom(String roomId, String userId);
  Future<void> ensureMemberJoinedAt(String roomId, String userId);
  Future<void> leaveRoom(String roomId, String userId);
}

class FirestoreRoomRepository implements RoomRepository {
  final FirebaseFirestore _firestore;

  FirestoreRoomRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _roomsCollection =>
      _firestore.collection(FirestoreCollections.rooms);

  RoomModel _roomFromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return RoomModel.fromJson({...data, 'id': data['id'] ?? doc.id});
  }

  @override
  Stream<List<RoomModel>> getRooms() {
    return _roomsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map(_roomFromDoc).toList();
    });
  }

  @override
  Stream<List<RoomModel>> getUserRooms(String userId) {
    return _roomsCollection
        .where('members', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map(_roomFromDoc).toList();
        });
  }

  @override
  Future<RoomModel> createRoom(RoomModel room) async {
    final trimmedName = room.name.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('Room name cannot be empty.');
    }

    final roomRef = room.id.isEmpty
        ? _roomsCollection.doc()
        : _roomsCollection.doc(room.id);
    final createdAt = room.createdAt ?? DateTime.now();
    final members = {...room.members, room.creatorId}.toList();
    final createdRoom = room.copyWith(
      id: roomRef.id,
      name: trimmedName,
      members: members,
      createdAt: createdAt,
      memberJoinedAt: {...room.memberJoinedAt, room.creatorId: createdAt},
    );

    await roomRef.set(createdRoom.toJson());
    return createdRoom;
  }

  @override
  Future<void> joinRoom(String roomId, String userId) async {
    if (userId.trim().isEmpty) {
      throw ArgumentError('User id cannot be empty.');
    }

    final roomRef = _roomsCollection.doc(roomId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(roomRef);
      if (!snapshot.exists) {
        throw StateError('Room does not exist.');
      }

      final members =
          (snapshot.data()?['members'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];

      if (members.contains(userId)) {
        throw StateError('Already joined.');
      }

      transaction.update(roomRef, {
        'members': FieldValue.arrayUnion([userId]),
        'memberJoinedAt.$userId': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> ensureMemberJoinedAt(String roomId, String userId) async {
    final roomRef = _roomsCollection.doc(roomId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(roomRef);
      if (!snapshot.exists) {
        throw StateError('Room does not exist.');
      }

      final data = snapshot.data() ?? const <String, dynamic>{};
      final memberJoinedAt =
          data['memberJoinedAt'] as Map<String, dynamic>? ?? const {};
      if (memberJoinedAt.containsKey(userId)) {
        return;
      }

      transaction.update(roomRef, {
        'memberJoinedAt.$userId': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> leaveRoom(String roomId, String userId) async {
    await _roomsCollection.doc(roomId).update({
      'members': FieldValue.arrayRemove([userId]),
      'memberJoinedAt.$userId': FieldValue.delete(),
    });
  }
}
