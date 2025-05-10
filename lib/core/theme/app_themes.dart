import 'package:flutter/material.dart';

import '../utils/app_constance.dart';

abstract class AppThemes {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
    ),
    canvasColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppConstance.primaryColor,
      unselectedItemColor: Colors.black26,
      showUnselectedLabels: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: AppConstance.darkModeThemeColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppConstance.darkModeThemeColor,
      iconTheme: IconThemeData(color: Colors.white), // Icons color
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[600],
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.white
      ),
      elevation: 10,
    ),
  );
}
