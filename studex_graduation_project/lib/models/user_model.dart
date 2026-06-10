import '../core/constants/user_roles.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'role': role,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? UserRoles.student,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          name == other.name &&
          role == other.role;

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ name.hashCode ^ role.hashCode;
}
