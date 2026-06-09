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
}
