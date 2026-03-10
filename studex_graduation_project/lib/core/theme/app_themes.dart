import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';


class AppThemes{
  static final ThemeData lightTheme =ThemeData(

      primaryColor: AppColors.primaryLight,
      shadowColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.whiteBgColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.primaryLight
        ),
      ),
      dividerColor: AppColors.whiteColor,
      focusColor: AppColors.whiteColor,
      splashColor: AppColors.greyColor,
      cardColor: AppColors.blackBgColor,
      textTheme: TextTheme(headlineLarge: AppStyles.bold20black,
          headlineMedium: AppStyles.medium16primary,titleMedium: AppStyles.bold16white,
          bodyLarge: AppStyles.medium16grey,titleSmall: AppStyles.bold16black
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryLight,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight,
          shape: StadiumBorder(
              side: BorderSide(
                color: AppColors.whiteColor,
                width: 5,
              )
          )
      )
  );
  static final ThemeData darkTheme =ThemeData(
      primaryColor: AppColors.primaryDark,
      shadowColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.primaryDark,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.primaryLight
        ),
      ),
      dividerColor: AppColors.primaryDark,
      focusColor: AppColors.primaryLight,
      splashColor: AppColors.primaryLight,
      cardColor: AppColors.whiteColor,


      textTheme: TextTheme(headlineLarge: AppStyles.bold20white,
          headlineMedium: AppStyles.medium16white,titleMedium: AppStyles.bold16primaryDark,
          bodyLarge: AppStyles.medium16white,
          titleSmall: AppStyles.bold16white
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(
                color: AppColors.whiteColor,
                width: 5,
              )
          )
      )
  );
}