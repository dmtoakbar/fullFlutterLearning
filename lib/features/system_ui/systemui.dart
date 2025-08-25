import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SystemUi {
  // status bar for splash screen
  static void statusBarForSplashScreen() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent background
        statusBarIconBrightness: Brightness.light, // Light icons (white)
      ),
    );
  }


  // status bar for all screen except splash screen
  static void statusBarForAllScreenExceptSplashScreen() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF2F2F2), // Light Grey
        statusBarIconBrightness: Brightness.dark, // Dark Icons
      ),
    );
  }


  // bottom action bar
 static void bottomActionBar() {
   SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(
       systemNavigationBarColor: Colors.green, // Bottom nav bar background color (black here)
       systemNavigationBarIconBrightness: Brightness.light, // Icon color (light icons for dark background)
       statusBarColor: Color(0xFFF2F2F2), // Top status bar color
       statusBarIconBrightness: Brightness.dark, // Top status bar icons
     ),
   );

 }
}