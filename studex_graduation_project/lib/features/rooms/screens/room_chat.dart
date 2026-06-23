import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/chat_bubble.dart';
import '../widgets/chat_header_info.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/date_chip.dart';

class RoomChatScreen extends StatelessWidget {
  const RoomChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: _buildAppBar(context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const ChatHeaderInfo(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.w),
                children: const [
                  DateChip(label: "اليوم"),
                  ChatBubble(
                    message: "مرحباً جميعاً، هل بدأتم بمذاكرة الوحدة الأولى؟",
                    userName: "أحمد علي",
                    time: "10:30",
                    isMe: false,
                    userImage: 'https://i.pravatar.cc/100?u=1',
                  ),
                  ChatBubble(
                    message:
                        "أهلاً أحمد، نعم بدأت للتو. هل واجهت أي صعوبة في الجزء العملي؟",
                    userName: "أنا",
                    time: "10:32",
                    isMe: true,
                    userImage: 'https://i.pravatar.cc/100?u=me',
                  ),
                  ChatBubble(
                    message:
                        "أنا أيضاً أواجه مشكلة في فهم مخططات الـ UML. هل يمكننا مناقشتها لاحقاً؟",
                    userName: "سارة محمود",
                    time: "10:35",
                    isMe: false,
                    userImage: 'https://i.pravatar.cc/100?u=3',
                  ),
                ],
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
        "هندسة برمجيات 1",
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
                color: Color(0xff6A6EF6),
              ),
            ),
            onPressed: () => context.pop(),
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
      child: Icon(icon, color: Color(0xff6A6EF6), size: 20.sp),
    );
  }
}
