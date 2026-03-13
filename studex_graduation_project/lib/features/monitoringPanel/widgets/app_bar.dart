import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMenuTap;

  const DashboardAppBar({
    super.key,
    this.onProfileTap,
    this.onNotificationTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF8F9FF),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,

      leading: IconButton(
        onPressed: onProfileTap,
        icon: CircleAvatar(
          radius: 18.r,
          backgroundColor: const Color(0xFFB3CEE5),
          child: Icon(
            Icons.account_circle_outlined,
            color: AppColors.primaryLight,
            size: 16.sp,
          ),
        ),
      ),
      title: Text('لوحة المتابعة', style: AppStyles.bold20black),
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).cardColor,
          ),
        ),
        IconButton(
          onPressed: onMenuTap,
          icon: Icon(Icons.menu, color: Theme.of(context).cardColor),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
