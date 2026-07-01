import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RoomModel {
  final String id;
  final String name;
  final String description;
  final String type; // public, private
  final String creatorId;
  final List<String> members;
  final Map<String, DateTime?> memberJoinedAt;
  final DateTime? createdAt;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final String? lastSenderId;

  const RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.creatorId,
    this.members = const [],
    this.memberJoinedAt = const {},
    this.createdAt,
    this.lastMessage,
    this.lastMessageAt,
    this.lastSenderId,
  });

  RoomModel copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    String? creatorId,
    List<String>? members,
    Map<String, DateTime?>? memberJoinedAt,
    DateTime? createdAt,
    String? lastMessage,
    DateTime? lastMessageAt,
    String? lastSenderId,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      creatorId: creatorId ?? this.creatorId,
      members: members ?? this.members,
      memberJoinedAt: memberJoinedAt ?? this.memberJoinedAt,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastSenderId: lastSenderId ?? this.lastSenderId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'creatorId': creatorId,
      'members': members,
      'memberJoinedAt': memberJoinedAt.map(
        (key, value) => MapEntry(key, value),
      ),
      'createdAt': createdAt,
      'lastMessage': lastMessage,
      'lastMessageAt': lastMessageAt,
      'lastSenderId': lastSenderId,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseTimestamp(dynamic value) {
      if (value == null) {
        return null;
      }
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      return DateTime.tryParse(value.toString());
    }

    return RoomModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? 'public',
      creatorId: json['creatorId'] as String? ?? '',
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      memberJoinedAt:
          (json['memberJoinedAt'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, parseTimestamp(value)),
          ) ??
          const {},
      createdAt: parseTimestamp(json['createdAt']),
      lastMessage: json['lastMessage'] as String?,
      lastMessageAt: parseTimestamp(json['lastMessageAt']),
      lastSenderId: json['lastSenderId'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          type == other.type &&
          creatorId == other.creatorId &&
          listEquals(members, other.members) &&
          mapEquals(memberJoinedAt, other.memberJoinedAt) &&
          createdAt == other.createdAt &&
          lastMessage == other.lastMessage &&
          lastMessageAt == other.lastMessageAt &&
          lastSenderId == other.lastSenderId;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    type,
    creatorId,
    Object.hashAll(members),
    Object.hashAll(
      memberJoinedAt.entries.map(
        (entry) => Object.hash(entry.key, entry.value),
      ),
    ),
    createdAt,
    lastMessage,
    lastMessageAt,
    lastSenderId,
  );
}
