import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'controllers/locale_controller.dart';
import 'utils/locale_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeService = LocaleService();
  await localeService.loadTranslations();

  final localeController = Get.put(LocaleController());
  await localeController.loadLocale();

  runApp(MyApp(localeService: localeService));
}

class MyApp extends StatelessWidget {
  final LocaleService localeService;

  const MyApp({required this.localeService, super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: localeService,
      locale: Get.find<LocaleController>().locale.value,
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // now recognized
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
