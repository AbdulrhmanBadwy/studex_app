import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class ChatBubble extends StatelessWidget {
  final String message, userName, time, userImage;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.userName,
    required this.time,
    required this.isMe,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMe) _userAvatar(),
          const WidthSpacing(8),
          Expanded(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const HeightSpacing(5),
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xff6A6EF6) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe ? 20.r : 0),
                      topRight: Radius.circular(isMe ? 0 : 20.r),
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      height: 1.4.h,
                    ),
                  ),
                ),
                const HeightSpacing(5),
                Text(
                  time,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          const WidthSpacing(8),
          if (!isMe) _userAvatar(),
        ],
      ),
    );
  }

  Widget _userAvatar() {
    return CircleAvatar(
      radius: 18.r,
      backgroundImage: NetworkImage(userImage),
    );
  }
}