import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocaleService extends Translations {
  Map<String, Map<String, String>> _translations = {};

  Future<void> loadTranslations() async {
    final enJson = await rootBundle.loadString('lib/allWidgets/MaterialApp/language/locales/en.json');
    final hiJson = await rootBundle.loadString('lib/allWidgets/MaterialApp/language/locales/hi.json');

    _translations = {
      'en_US': Map<String, String>.from(json.decode(enJson)),
      'hi_IN': Map<String, String>.from(json.decode(hiJson)),
    };
  }

  @override
  Map<String, Map<String, String>> get keys => _translations;
}
