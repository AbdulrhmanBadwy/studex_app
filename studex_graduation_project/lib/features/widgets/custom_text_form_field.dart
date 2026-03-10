import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
typedef onValidator = String? Function(String?)?;
class CustomTextFormField extends StatelessWidget {
  Color borderSideColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  onValidator? validator;
  TextInputType? keyboardType;
  int? maxLines;
  bool? obscureText;
  TextEditingController controller;
  CustomTextFormField({super.key,this.borderSideColor = AppColors.greyColor,
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
      decoration: InputDecoration(
        enabledBorder:builtDecorationBorder(borderSideColor: borderSideColor),
        focusedBorder: builtDecorationBorder(borderSideColor: borderSideColor),
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
