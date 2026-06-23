import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

class RoomCard extends StatelessWidget {
  final String title, category, description, memberCount, tag, status;
  final Color tagColor;

  const RoomCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.memberCount,
    required this.tag,
    required this.tagColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutes.roomChatScreen),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Stack(
          children: [
            // الـ Tag اللي فوق عاليمين
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                    const WidthSpacing(4),
                    Text(
                      status,
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    ),
                  ],
                ),
                const HeightSpacing(12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  category,
                  style: TextStyle(color: Color(0xff6A6EF6), fontSize: 14.sp),
                ),
                const HeightSpacing(8),
                Text(
                  description,
                  style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                  maxLines: 2,
                ),
                const HeightSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر الدخول المصمم
                    Container(
                      width: 50.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryAllColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          "دخول",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            height: 1.1.h,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AbdoMaster',
                          ),
                        ),
                      ),
                    ),
                    Row(children: [_buildMemberStack(memberCount)]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberStack(String count) {
    return SizedBox(
      width: 100.w,
      height: 35.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(right: 0, child: _avatar('https://i.pravatar.cc/100?u=1')),
          Positioned(
            right: 20.w,
            child: _avatar('https://i.pravatar.cc/100?u=2'),
          ),
          Positioned(
            right: 40.w,
            child: _avatar('https://i.pravatar.cc/100?u=3'),
          ),
          Positioned(
            right: 60.w,
            child: CircleAvatar(
              radius: 16.r,
              backgroundColor: const Color(0xffF0F2F5),
              child: Text(
                count,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(String url) {
    return CircleAvatar(
      radius: 17.r,
      backgroundColor: Colors.white,
      child: CircleAvatar(radius: 15.r, backgroundImage: NetworkImage(url)),
    );
  }
}
