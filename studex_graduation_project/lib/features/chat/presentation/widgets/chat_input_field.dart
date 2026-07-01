import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

import 'package:studex_graduation_project/features/chat/presentation/cubits/chat_cubit.dart'
    show ChatCubit;

class ChatInputField extends StatefulWidget {
  final String roomId;

  const ChatInputField({super.key, required this.roomId});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('مينفعش تبعت ماسدج فاضية '),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 16,
            right: 16,
          ),
        ),
      );
      return;
    }

    context.read<ChatCubit>().sendMessage(text);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _sendMessage(context);
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: Color(0xff6A6EF6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send_rounded, color: Colors.white, size: 24.sp),
            ),
          ),
          const WidthSpacing(12),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "اكتب رسالتك هنا...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                filled: true,
                fillColor: const Color(0xffF1F2F6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.grey,
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.createQuizz,
                      extra: {'roomId': widget.roomId},
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
