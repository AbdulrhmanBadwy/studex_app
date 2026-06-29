import 'package:flutter/foundation.dart';

class RoomModel {
  final String id;
  final String name;
  final String description;
  final String type; // public, private
  final String creatorId;
  final List<String> members;

  const RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.creatorId,
    this.members = const [],
  });

  RoomModel copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    String? creatorId,
    List<String>? members,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      creatorId: creatorId ?? this.creatorId,
      members: members ?? this.members,
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
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
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
          listEquals(members, other.members);

  @override
  int get hashCode =>
      Object.hash(
        id,
        name,
        description,
        type,
        creatorId,
        Object.hashAll(members),
      );
}
