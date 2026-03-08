import 'package:flutter/material.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class CustomBotton extends StatelessWidget {
  String text;
  VoidCallback onTap;
   CustomBotton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius:
            BorderRadius.circular(20)
        ),
        child:Center(child: Text(text,style: AppStyles.medium16black,)) ,
      ),
    );
  }
}
