import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/controller/theme_manager.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/settings.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = ThemeManager.themeNotifier.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current Theme: ${mode.name}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              ),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
