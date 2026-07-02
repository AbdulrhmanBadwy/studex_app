import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';


class ChatHeaderInfo extends StatelessWidget {
  const ChatHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(16.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "برمجيات",
                      style: TextStyle(
                        color: Color(0xff6A6EF6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "15 عضو نشط حالياً",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const WidthSpacing( 15),
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                      fit: BoxFit.cover              ,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
