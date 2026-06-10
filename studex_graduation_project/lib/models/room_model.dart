class RoomModel {
  final String id;
  final String name;
  final String description;
  final String type; // public, private
  final String creatorId;

  const RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.creatorId,
  });

  RoomModel copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    String? creatorId,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      creatorId: creatorId ?? this.creatorId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'creatorId': creatorId,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? 'public',
      creatorId: json['creatorId'] as String? ?? '',
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
          creatorId == other.creatorId;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ type.hashCode ^ creatorId.hashCode;
}
