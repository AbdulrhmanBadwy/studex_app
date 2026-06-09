import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
typedef OnValidator = String? Function(String?)?;
class CustomTextFormFieldd extends StatelessWidget {
  final Color borderSideColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final OnValidator? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? obscureText;
  final TextEditingController controller;
  const CustomTextFormFieldd({super.key,this.borderSideColor = AppColors.greyColor,
    this.hintStyle , this.hintText , this.labelStyle , this.labelText,
    this.prefixIcon , this.suffixIcon,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.obscureText = false,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        color: AppColors.blackBgColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        focusColor: AppColors.blackBgColor,
        enabledBorder:builtDecorationBorder(borderSideColor: borderSideColor),
        focusedBorder: builtDecorationBorder(borderSideColor: borderSideColor,),
        errorBorder: builtDecorationBorder(borderSideColor: AppColors.redColor),
        focusedErrorBorder: builtDecorationBorder(borderSideColor: AppColors.redColor),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.medium16grey,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.medium16grey,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
OutlineInputBorder builtDecorationBorder({required Color borderSideColor}){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderSideColor,
        width: 1,
      )
  );
}
