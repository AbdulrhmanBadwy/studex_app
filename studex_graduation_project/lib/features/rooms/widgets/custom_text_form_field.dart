import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final double? width;
  final double? heigh;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.width,
    this.controller,
    this.validator,
    this.heigh,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpandable = maxLines == null && heigh != null;

    return SizedBox(
      width: (width ?? 358).w,
      height: (heigh ?? 56).h,
      child: TextFormField(
        expands: isExpandable,
        maxLines: isExpandable ? null : (maxLines ?? 1),
        minLines: isExpandable ? null : 1,

        textAlignVertical: isExpandable ? TextAlignVertical.top : TextAlignVertical.center,

        style: TextStyle(
          color: Colors.black,
          fontFamily: 'AbdoMaster',
          fontSize: 14.sp,
        ),
        controller: controller,
        validator: validator,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xff94A3B8),
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: isExpandable ? 18.h : 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: const Color(0xffE8ECF4), width: 1.sp),
          ),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.blackHeadLine, width: 1.sp),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: Colors.red, width: 1.sp),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.blackHeadLine, width: 1.sp),
          ),
        ),
      ),
    );
  }
}