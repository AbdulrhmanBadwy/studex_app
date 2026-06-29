import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

class QuizResult extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback? onBackToRoom;

  const QuizResult({
    super.key,
    required this.score,
    required this.total,
    this.onBackToRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B2340),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: const Color(0xFF6C63FF),
                  size: 50.sp,
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                score / total >= 0.5 ? 'ايه الحلاوة دي !' : 'شد حيلك يا نجم',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B2340),
                ),
              ),

              SizedBox(height: 36.h),

              // Score circle
              Container(
                width: 180.w,
                height: 180.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryAllColor,
                    width: 10.w,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score/$total',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6C63FF),
                      ),
                    ),
                    Text(
                      'نقاط الإجابة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 36.h),

              // ✅ only correct answers card
              _StatCard(
                icon: Icons.check_circle_outline,
                iconColor: Colors.green,
                label: 'الإجابات الصحيحة',
                value: '$score',
              ),

              SizedBox(height: 32.h),

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton.icon(
                  onPressed: onBackToRoom,
                  icon: const Icon(
                    Icons.meeting_room_outlined,
                    color: Color(0xFF1B2340),
                  ),
                  label: Text(
                    'ارجع للروم',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B2340),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value; // ✅ added back

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value, // ✅ required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 26.sp),
          SizedBox(height: 8.h),
          Text(
            label,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'AbdoMaster',
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value, // ✅ fixed
            style: TextStyle(
              fontFamily: 'AbdoMaster',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B2340),
            ),
          ),
        ],
      ),
    );
  }
}