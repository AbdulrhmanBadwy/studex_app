import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/models/room_model.dart';

void main() {
  test('RoomModel serializes with empty members', () {
    const room = RoomModel(
      id: 'r1',
      name: 'Math',
      description: 'Desc',
      type: 'public',
      creatorId: 'u1',
    );

    final json = room.toJson();
    expect(json['members'], <String>[]);

    final restored = RoomModel.fromJson(json);
    expect(restored.members, isEmpty);
    expect(restored, equals(room));
  });

  test('RoomModel serializes with existing members', () {
    const room = RoomModel(
      id: 'r2',
      name: 'Physics',
      description: 'Group',
      type: 'public',
      creatorId: 'u2',
      members: ['u2', 'u3'],
    );

    final json = room.toJson();
    expect(json['members'], ['u2', 'u3']);

    final restored = RoomModel.fromJson(json);
    expect(restored.members, ['u2', 'u3']);
    expect(restored, equals(room));
  });

  test('RoomModel deserializes members safely', () {
    final room = RoomModel.fromJson({
      'id': 'r3',
      'name': 'Chemistry',
      'description': 'Lab room',
      'type': 'public',
      'creatorId': 'u4',
      'members': ['u4', 99, true],
    });

    expect(room.members, ['u4', '99', 'true']);
  });

  test('RoomModel copyWith keeps original room intact', () {
    const room = RoomModel(
      id: 'r1',
      name: 'Math',
      description: 'Desc',
      type: 'public',
      creatorId: 'u1',
      members: ['u1'],
    );

    final modified = room.copyWith(name: 'Physics');
    expect(modified.name, 'Physics');
    expect(room.name, 'Math');
  });
}
