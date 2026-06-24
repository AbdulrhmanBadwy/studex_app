part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatLoaded extends ChatState {
  final List<MessageModel> messages;

  ChatLoaded({required this.messages});

}

final class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});
}
final class ChatMessageSent extends ChatState {
  final MessageModel message;

  ChatMessageSent({required this.message});
}
final class ChatMessageDeleted extends ChatState {
  final String messageId;

  ChatMessageDeleted({required this.messageId});
}