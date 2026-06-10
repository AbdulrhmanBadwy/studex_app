import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/models/room_model.dart';

void main() {
  test('RoomModel toJson/fromJson and copyWith', () {
    final room = RoomModel(id: 'r1', name: 'Math', description: 'Desc', type: 'public', creatorId: 'u1');
    final json = room.toJson();
    final restored = RoomModel.fromJson(json);
    expect(restored, equals(room));

    final modified = room.copyWith(name: 'Physics');
    expect(modified.name, 'Physics');
    expect(room.name, 'Math');
  });
}
