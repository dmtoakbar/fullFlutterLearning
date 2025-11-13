import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/constant/dark_theme.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/constant/light_theme.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/controller/theme_manager.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.init(); // Load saved theme
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Theme Switch Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          home: const HomePage(),
        );
      },
    );
  }
}
