import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/custom_button_nav_bar.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onContinueOffline;

  const NoInternetScreen({super.key, this.onRetry, this.onContinueOffline});

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
          title: Text(
            'StudySync',
            style: TextStyle(
              fontFamily: 'AbdoMaster',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff0F172A),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Icon(
                Icons.wifi_off_rounded,
                color: const Color(0xff94A3B8),
                size: 22.sp,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: const Color(0xff0F172A),
              size: 22.sp,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Illustration
              Container(
                width: 140.w,
                height: 140.w,
                decoration: BoxDecoration(
                  color: const Color(0xffF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.wifi_off_rounded,
                  size: 64.sp,
                  color: const Color(0xff94A3B8),
                ),
              ),
              HeightSpacing(32),

              // Title
              Text(
                'لا يوجد اتصال بالإنترنت',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0F172A),
                ),
              ),
              HeightSpacing(12),

              // Subtitle
              Text(
                'تحقق من إعدادات الشبكة وحاول مرة أخرى، أو تابع للعودة إلى ما كنت تفعله.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 14.sp,
                  color: const Color(0xff64748B),
                  height: 1.6,
                ),
              ),
              HeightSpacing(40),

              // Retry button
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton.icon(
                  onPressed: onRetry ?? () => context.go(AppRoutes.homeScreen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAllColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  label: Text(
                    'إعادة المحاولة',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              HeightSpacing(12),

              // Offline button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: TextButton(
                  onPressed:
                      onContinueOffline ??
                      () => context.go(AppRoutes.homeScreen),
                  child: Text(
                    'العمل بدون اتصال',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 14.sp,
                      color: const Color(0xff64748B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom nav bar
        bottomNavigationBar: const CustomButtonNavBar(),
      ),
    );
  }
}
