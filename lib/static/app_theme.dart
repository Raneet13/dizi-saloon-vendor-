import 'package:dizisalon_vender/static/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
 static ThemeData themedata = ThemeData(
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colo.primaryColor, //Color(0xfffac50e),
          background: Colo.primaryColor),
      useMaterial3: true,
      scaffoldBackgroundColor: Colo.white,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        titleLarge: TextStyle(
            color: Colo.black, fontSize: 21, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(),
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
            color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            color: Colors.black38,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3),
        labelSmall:
            TextStyle(color: Colors.black26, fontSize: 12, letterSpacing: 0.3),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colo.white,
        backgroundColor: Colo.primaryColor,
        iconTheme: IconThemeData(color: Colo.primaryColor),
        titleTextStyle: TextStyle(color: Colo.primaryColor),
        actionsIconTheme: IconThemeData(color: Colo.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colo.secondaryColor, // Navigation bar
          statusBarColor: Colo.secondaryColor, // Status bar
        ),
      ),
      // listTileTheme: ListTileThemeData(
      //     minVerticalPadding: 0,
      //     tileColor: Colors.black,
      //     selectedColor: Colors.blue,
      //     selectedTileColor: Colors.blue[50],
      //     iconColor: Colors.black,
      //     textColor: Colors.black,
      //     contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     titleTextStyle: TextStyle(color: Colo.black44)),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        // foregroundColor: Colo.white,
        // surfaceTintColor: Colors.transparent,
        // disabledBackgroundColor: Colo.primaryColor,
        // disabledForegroundColor: Colo.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20), // Rounded corners
        // ),
        // shape: MaterialStatePropertyAll(RoundedRectangleBorder(

        //     borderRadius: BorderRadius.circular(15),
        //     side: BorderSide(color: Colors.black38))),
        textStyle: TextStyle(fontSize: 18, color: Colo.black),
      )),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              // disabledForegroundColor: Colo.white,
              // foregroundColor: Colo.white,
              // backgroundColor: Colo.black,
              // disabledBackgroundColor: Colo.white,
              padding: EdgeInsets.zero, // Zero padding
              minimumSize: Size(0, 0), // Minimum size of the button
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: TextStyle(fontSize: 18, color: Colo.black))));
}
