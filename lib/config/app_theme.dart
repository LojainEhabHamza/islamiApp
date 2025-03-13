import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';

class AppTheme{
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.transparentColor,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDarkColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.primaryDarkColor,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
    )
  );
}