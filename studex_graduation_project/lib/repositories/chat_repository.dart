import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studex_graduation_project/models/message_model.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> getMessages(String roomId);
  Future<void> sendMessage(String roomId, MessageModel message);
  Future<void> deleteMessage(String roomId, String messageId);
}

class FirestoreChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore;

  FirestoreChatRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _roomsCollection =>
      _firestore.collection('rooms');

  @override
  Stream<List<MessageModel>> getMessages(String roomId) {
    return _roomsCollection
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList();
        });
  }

  @override
  Future<void> sendMessage(String roomId, MessageModel message) async {
    final roomRef = _roomsCollection.doc(roomId);
    final messageRef = roomRef.collection('messages').doc(message.id);
    final previewMessage = message.message.length > 100
        ? message.message.substring(0, 100)
        : message.message;

    final batch = _firestore.batch();
    batch.set(messageRef, message.toJson());
    batch.update(roomRef, {
      'lastMessage': previewMessage,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastSenderId': message.senderId,
    });

    await batch.commit();
  }

  @override
  Future<void> deleteMessage(String roomId, String messageId) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }
}
