import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      message: json['message'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'message': message,
      'createdAt': createdAt,
    };
  }
}