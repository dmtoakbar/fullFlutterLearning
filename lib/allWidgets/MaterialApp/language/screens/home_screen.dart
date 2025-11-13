import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello'.tr, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('welcome'.tr),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.to(() => const ProfileScreen()),
              child: Text('go_to_profile'.tr),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Get.to(() => const SettingsScreen()),
              child: Text('go_to_settings'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
