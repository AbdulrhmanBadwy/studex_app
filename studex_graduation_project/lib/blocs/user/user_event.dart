import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class FetchCurrentUserRequested extends UserEvent {
  final String uid;

  const FetchCurrentUserRequested({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class UpdateProfileRequested extends UserEvent {
  final UserModel user;

  const UpdateProfileRequested({required this.user});

  @override
  List<Object?> get props => [user];
}
