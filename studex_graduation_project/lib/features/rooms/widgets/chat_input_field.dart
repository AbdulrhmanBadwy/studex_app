import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
          Container(
            padding:  EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xff6A6EF6),
              shape: BoxShape.circle,
            ),
            child:  Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          const WidthSpacing( 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "اكتب رسالتك هنا...",
                hintStyle:  TextStyle(color: Colors.grey, fontSize: 14.sp),
                filled: true,
                fillColor: const Color(0xffF1F2F6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding:  EdgeInsets.symmetric(horizontal: 20.w),
                suffixIcon:  IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.add_circle_outline) ,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}