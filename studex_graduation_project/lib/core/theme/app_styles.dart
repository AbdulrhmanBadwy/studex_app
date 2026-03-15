import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';



class AppStyles{
  static TextStyle primaryHeadlineStyle = TextStyle(
    fontFamily: 'AbdoMaster',
    fontSize: 20.sp ,
    fontWeight: FontWeight.w800,
    color: AppColors.blackHeadLine,

  );

  static TextStyle textItemInSettings = TextStyle(
    fontFamily: 'AbdoMaster',
    fontSize: 16.sp ,
    fontWeight: FontWeight.bold,
    color: AppColors.blackHeadLine,
  );
  static TextStyle bold20black = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.blackBgColor
  );
  static TextStyle bold30black = GoogleFonts.inter(
      fontSize: 30, fontWeight: FontWeight.bold,color:AppColors.blackBgColor
  );
  static TextStyle bold16black = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.blackBgColor,
  );
  static TextStyle medium16black = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500,color: AppColors.blackBgColor
  );
  static TextStyle bold20white = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.whiteColor
  );
  static TextStyle bold24white = GoogleFonts.inter(
      fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.whiteColor
  );
  static TextStyle medium16white = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w500,color: AppColors.whiteColor
  );
  static TextStyle medium14white = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w500,color: AppColors.whiteColor
  );
  static TextStyle bold20primary = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryLight
  );
  static TextStyle medium24primary = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w900,color: AppColors.primaryLight
  );
  static TextStyle bold16primary = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.primaryLight
  );
  static TextStyle bold16primaryDark = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.primaryDark
  );
  static TextStyle bold16white = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.whiteColor
  );
  static TextStyle medium16primary = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400,color: AppColors.primaryLight
  );
  static TextStyle medium16grey = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400,color: AppColors.greyColor
  );
  static TextStyle primaryBoldBlue18 = GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.primaryAllColor
  );
  static TextStyle primaryBlue = GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w400,color: AppColors.primaryAllColor
  );


}
