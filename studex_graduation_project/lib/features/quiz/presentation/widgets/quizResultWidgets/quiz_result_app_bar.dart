import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class QuizResultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const QuizResultAppBar({super.key, required this.title, this.onBackPressed});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster'),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1B2340)),
        onPressed: onBackPressed,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
