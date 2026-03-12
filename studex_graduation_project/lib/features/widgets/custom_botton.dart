import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool hasIcon;

  final Widget? childIconWidget;

  const CustomButton({super.key,required this.onPressed, this.text,
    this.backgroundColor = AppColors.primaryLight,this.borderColor = AppColors.transparent,
    this.textStyle, this.hasIcon = false ,
    this.childIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(400, 20),
            backgroundColor: backgroundColor,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: height*0.02),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
                side: BorderSide(
                  color: borderColor!,
                  width: 2,
                )
            )
        ),
        onPressed: onPressed,
        child: hasIcon ?
        childIconWidget!
            :
        Text(text??'',
          style:textStyle ?? AppStyles.bold20white,)
    );
  }
}
