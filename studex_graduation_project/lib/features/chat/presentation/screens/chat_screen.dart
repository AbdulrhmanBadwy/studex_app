import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:studex_graduation_project/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:studex_graduation_project/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:studex_graduation_project/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:studex_graduation_project/features/rooms/widgets/chat_header_info.dart';
import 'package:studex_graduation_project/models/message_model.dart';
import 'package:studex_graduation_project/repositories/chat_repository.dart';

class RoomChatScreen extends StatefulWidget {
  final String roomId;
  final String roomName;
  const RoomChatScreen({
    super.key,
    required this.roomId,
    required this.roomName,
  });

  @override
  State<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends State<RoomChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ChatCubit(FirestoreChatRepository(), widget.roomId)..getMessages(),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FD),
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            const ChatHeaderInfo(),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ChatError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  }

                  if (state is ChatLoaded) {
                    _scrollToBottom();
                  }

                  final List<MessageModel> messages = state is ChatLoaded
                      ? state.messages
                      : [];
                  final chatCubit = context.read<ChatCubit>();

                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(20.w),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: messages[index].message,
                        userName: messages[index].senderName,
                        time: DateFormat(
                          'hh:mm a',
                        ).format(messages[index].createdAt),
                        isMe: messages[index].senderId == chatCubit.userId,
                        userImage: '',
                      );
                    },
                  );
                },
              ),
            ),
            const ChatInputField(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: _iconBox(Icons.copy_rounded),
      title: Text(
        widget.roomName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: IconButton(
            icon: CircleAvatar(
              backgroundColor: const Color(0xffEEF0FF),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: const Color(0xff6A6EF6),
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xffEEF0FF),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: const Color(0xff6A6EF6), size: 20.sp),
    );
  }
}
