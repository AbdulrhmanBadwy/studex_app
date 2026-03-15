import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppStyles.primaryHeadlineStyle.copyWith(
        color: Colors.black,
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        hintText: "ابحث عن غرفة أو مادة",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14 , fontFamily: 'AbdoMaster'),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}