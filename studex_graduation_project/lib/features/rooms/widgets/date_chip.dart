
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateChip extends StatelessWidget {
  final String label;
  const DateChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: 20.h),
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xffEEF0FF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style:  TextStyle(
            color: Color(0xff6A6EF6),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
