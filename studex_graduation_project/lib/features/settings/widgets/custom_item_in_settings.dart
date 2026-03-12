import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class CustomItemInSettings extends StatelessWidget {
  final String title;
  final String icon;
  final IconData trailingIcon;
  const CustomItemInSettings({
    super.key,
    required this.title,
    required this.icon, required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width:356.w ,
      height: 73.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r)
      ),
      child: ListTile(
        title: Text(title , style: AppStyles.textItemInSettings,),
        leading: SvgPicture.asset(icon ,width: 40.w, height: 40.h,),
        trailing: IconButton(onPressed: (){}, icon: Icon(trailingIcon)),
        ),
    );
  }
}
