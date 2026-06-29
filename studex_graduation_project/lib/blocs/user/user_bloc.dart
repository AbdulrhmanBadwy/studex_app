import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserInitial()) {
    on<FetchCurrentUserRequested>(_onFetchCurrentUserRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
  }

  Future<void> _onFetchCurrentUserRequested(
    FetchCurrentUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      final user = await userRepository.getCurrentUser(event.uid);
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(const UserFailure(message: 'User not found'));
      }
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      await userRepository.updateProfile(event.user);
      emit(UserLoaded(user: event.user));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }
}
