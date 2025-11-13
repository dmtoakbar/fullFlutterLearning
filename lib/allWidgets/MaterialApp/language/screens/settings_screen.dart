import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/locale_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocaleController>();

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'choose_language'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            RadioListTile<String?>(
              title: Text('system_default'.tr),
              value: null,
              groupValue: controller.isSystem.value ? null : controller.locale.value?.languageCode,
              onChanged: (value) => controller.changeLocale(value),
            ),
            RadioListTile<String?>(
              title: Text('english'.tr),
              value: 'en',
              groupValue: controller.isSystem.value ? null : controller.locale.value?.languageCode,
              onChanged: (value) => controller.changeLocale(value),
            ),
            RadioListTile<String?>(
              title: Text('hindi'.tr),
              value: 'hi',
              groupValue: controller.isSystem.value ? null : controller.locale.value?.languageCode,
              onChanged: (value) => controller.changeLocale(value),
            ),
          ],
        )),
      ),
    );
  }
}
