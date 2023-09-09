import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme{
  AppTheme._();


  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    tabBarTheme: const TabBarTheme(
        labelColor: Colors.white
    ),
  );

  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
      ),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.white
      )

  );

  static get getTheme{

  }

}