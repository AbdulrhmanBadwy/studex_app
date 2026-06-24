import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:studex_graduation_project/models/message_model.dart';
import 'package:studex_graduation_project/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final String roomId;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final String userName =
      FirebaseAuth.instance.currentUser!.displayName ?? 'Unknown User';
  final ChatRepository _repository;
  StreamSubscription? _messagesSubscription;

  ChatCubit(this._repository, this.roomId) : super(ChatInitial());

  Future<void> sendMessage(String messageText) async {
    final message = MessageModel(
      id: const Uuid().v4(),
      senderId: userId,
      senderName: userName,
      message: messageText,
      createdAt: DateTime.now(),
    );

    try {
      await _repository.sendMessage(roomId, message);
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  void getMessages() {
    emit(ChatLoading());
    _messagesSubscription = _repository
        .getMessages(roomId)
        .listen(
          (messages) => emit(ChatLoaded(messages: messages)),

          onError: (e) => emit(ChatError(message: e.toString())),
        );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
