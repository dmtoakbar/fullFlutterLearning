import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/app.dart';
import 'package:learn_getx_bloc_riverpod/features/system_ui/systemui.dart';

void main() {

  // system ui change ingit android
  SystemUi.statusBarForAllScreenExceptSplashScreen();
  SystemUi.bottomActionBar();
  runApp(const MyApp());
}