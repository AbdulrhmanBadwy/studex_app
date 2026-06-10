import 'package:flutter_test/flutter_test.dart';
import 'package:studex_graduation_project/models/user_model.dart';
import 'package:studex_graduation_project/core/constants/user_roles.dart';

void main() {
  test('UserModel toJson/fromJson and copyWith', () {
    final user = UserModel(uid: 'u1', email: 'a@b.com', name: 'Ali', role: UserRoles.student);
    final json = user.toJson();
    final restored = UserModel.fromJson(json);
    expect(restored, equals(user));

    final modified = user.copyWith(name: 'Ahmed', role: UserRoles.teacher);
    expect(modified.name, 'Ahmed');
    expect(modified.role, UserRoles.teacher);
    expect(user.name, 'Ali');
  });
}
