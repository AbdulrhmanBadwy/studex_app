import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

sealed class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final UserModel user;

  const UserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserFailure extends UserState {
  final String message;

  const UserFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
