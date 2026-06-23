import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int totalMarks;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.totalMarks,
  });

  double get _percentage => totalMarks > 0 ? (score / totalMarks) * 100 : 0;
  bool get _passed => _percentage >= 50;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('نتيجة الاختبار',
              style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster')),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1B2340)),
            onPressed: () => context.go(AppRoutes.homeScreen),
          ),
        ),
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
                    _passed ? Icons.emoji_events : Icons.sentiment_neutral,
                    color: const Color(0xFF6C63FF),
                    size: 50.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  _passed ? 'أداء رائع! ' : 'شد حيلك يا نجم ',
                  style: TextStyle(
                    fontFamily: 'AbdoMaster',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B2340),
                  ),
                ),
                SizedBox(height: 32.h),
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
                        '$score/$totalMarks',
                        style: TextStyle(
                          fontFamily: 'AbdoMaster',
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6C63FF),
                        ),
                      ),
                      Text(
                        'درجاتك',
                        style: TextStyle(
                          fontFamily: 'AbdoMaster',
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.h),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.check_circle_outline,
                        iconColor: Colors.green,
                        label: 'إجابات صحيحة',
                        value: '$score',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.quiz_outlined,
                        iconColor: const Color(0xFF6C63FF),
                        label: 'عدد الأسئلة',
                        value: '$totalQuestions',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.percent,
                        iconColor: Colors.orange,
                        label: 'النسبة',
                        value: '${_percentage.toStringAsFixed(0)}%',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go(AppRoutes.homeScreen),
                    icon: const Icon(Icons.home_outlined, color: Color(0xFF1B2340)),
                    label: Text(
                      'العودة للرئيسية',
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
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          SizedBox(height: 6.h),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 11.sp,
                  color: Colors.grey)),
          SizedBox(height: 4.h),
          Text(value,
              style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B2340))),
        ],
      ),
    );
  }
}