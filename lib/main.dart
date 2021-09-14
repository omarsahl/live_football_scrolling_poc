import 'package:flutter/material.dart';
import 'package:live_football_scrolling_poc/constants/colors.dart';
import 'package:live_football_scrolling_poc/screens/fixture_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.green,
        colorScheme: ColorScheme.light(
          primary: AppColors.green,
          onPrimary: Colors.white,
          secondary: AppColors.green,
          onSecondary: Colors.white,
          brightness: Brightness.light,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.green,
          unselectedItemColor: AppColors.lightGray,
        ),
        scaffoldBackgroundColor: AppColors.darkerWhite,
        iconTheme: IconThemeData(),
        shadowColor: Colors.black54,

      ),
      home: FixtureDetailsScreen(),
    );
  }
}
