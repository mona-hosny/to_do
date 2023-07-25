import 'package:flutter/material.dart';
import 'package:to_do/utiles/app_color.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColor.primaryColor,scaffoldBackgroundColor: AppColor.forthColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          titleTextStyle: TextStyle(
              fontSize: 22,
              color: AppColor.secondColor,
              fontWeight: FontWeight.bold),
          elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColor.secondColor,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.secondColor,
          showSelectedLabels: false,
          showUnselectedLabels: false),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.fifthColor)
          //for text green
          ,
          bodyLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor)
          // for task blue
          ,
          bodyMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: AppColor.forthColor)
          //for unselected calunder
          ,
          titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColor.primaryColor)
          //for selected calender
          ,
          titleSmall: TextStyle(
              fontSize: 12, color: AppColor.forthColor) //for number of watch
          ));
  static ThemeData darkTheme = ThemeData();
}
