import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/allWidgets/MaterialApp/theme/controller/theme_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode _current;

  @override
  void initState() {
    super.initState();
    _current = ThemeManager.themeNotifier.value;

    // Listen for theme updates
    ThemeManager.themeNotifier.addListener(_themeChanged);
  }

  void _themeChanged() {
    setState(() {
      _current = ThemeManager.themeNotifier.value;
    });
  }

  @override
  void dispose() {
    ThemeManager.themeNotifier.removeListener(_themeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Theme:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            DropdownButton<ThemeMode>(
              value: _current,
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ThemeManager.setTheme(mode);
                }
              },
            ),
            const SizedBox(height: 40),
            Container(
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.secondary,
              child: const Text('Preview Box'),
            ),
          ],
        ),
      ),
    );
  }
}
