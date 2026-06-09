import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';

abstract class RoomRepository {
  Stream<List<RoomModel>> getRooms();
  Future<void> createRoom(RoomModel room);
  Future<void> joinRoom(String roomId, String userId);
  Future<void> leaveRoom(String roomId, String userId);
}

class FirestoreRoomRepository implements RoomRepository {
  final FirebaseFirestore _firestore;

  FirestoreRoomRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _roomsCollection =>
      _firestore.collection('rooms');

  @override
  Stream<List<RoomModel>> getRooms() {
    return _roomsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => RoomModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> createRoom(RoomModel room) async {
    await _roomsCollection.doc(room.id).set(room.toJson());
  }

  @override
  Future<void> joinRoom(String roomId, String userId) async {
    await _roomsCollection.doc(roomId).update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }

  @override
  Future<void> leaveRoom(String roomId, String userId) async {
    await _roomsCollection.doc(roomId).update({
      'members': FieldValue.arrayRemove([userId]),
    });
  }
}
