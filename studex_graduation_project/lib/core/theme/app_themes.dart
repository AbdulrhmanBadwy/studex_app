import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';


class AppThemes{
  static final ThemeData lightTheme =ThemeData(

      primaryColor: AppColors.primaryLight,
      shadowColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.whiteBgColore,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.primaryLight
        ),
      ),
      dividerColor: AppColors.whiteColore,
      focusColor: AppColors.whiteColore,
      splashColor: AppColors.greyColor,
      indicatorColor: AppColors.greyColor,
      cardColor: AppColors.blackBgColore,
      textTheme: TextTheme(headlineLarge: AppStyles.bold20black,
          headlineMedium: AppStyles.medium16primary,titleMedium: AppStyles.bold16white,
          bodyLarge: AppStyles.medium16grey,titleSmall: AppStyles.bold16black
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryLight,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColore,
        unselectedItemColor: AppColors.whiteColore,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight,
          shape: StadiumBorder(
              side: BorderSide(
                color: AppColors.whiteColore,
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
      cardColor: AppColors.whiteColore,
      indicatorColor: AppColors.whiteColore,


      textTheme: TextTheme(headlineLarge: AppStyles.bold20white,
          headlineMedium: AppStyles.medium16white,titleMedium: AppStyles.bold16primaryDark,
          bodyLarge: AppStyles.medium16white,
          titleSmall: AppStyles.bold16white
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColore,
        unselectedItemColor: AppColors.whiteColore,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(
                color: AppColors.whiteColore,
                width: 5,
              )
          )
      )
  );
}