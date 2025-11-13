import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static const _key = 'languageCode';

  Rx<Locale?> locale = Rx<Locale?>(null);
  RxBool isSystem = true.obs; // make reactive

  /// Load saved locale or system default
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);

    if (code == null) {
      locale.value = Get.deviceLocale;
      isSystem.value = true;
    } else {
      locale.value = Locale(code);
      isSystem.value = false;
    }

    Get.updateLocale(locale.value!);
  }

  /// Change locale (null = system default)
  Future<void> changeLocale(String? languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    if (languageCode == null) {
      // System default
      await prefs.remove(_key);
      isSystem.value = true;
      locale.value = Get.deviceLocale;
    } else {
      // User selected language
      await prefs.setString(_key, languageCode);
      isSystem.value = false;
      locale.value = Locale(languageCode);
    }

    Get.updateLocale(locale.value!);
  }
}
