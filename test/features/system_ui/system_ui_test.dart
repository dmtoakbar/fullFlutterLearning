import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_getx_bloc_riverpod/features/system_ui/systemui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SystemUi', () {
    const channel = SystemChannels.platform;
    final log = <MethodCall>[];

    setUp(() {
      // Intercept platform messages
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        log.add(call);
        return null;
      });
      log.clear();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('statusBarForSplashScreen sets transparent with light icons', () async {
      SystemUi.statusBarForSplashScreen();

      expect(log, hasLength(1));
      final args = log.first.arguments as Map;
      expect(args['statusBarColor'], 0x00000000); // transparent
      expect(args['statusBarIconBrightness'], 'Brightness.light');
    });

    test('statusBarForAllScreenExceptSplashScreen sets light grey with dark icons', () async {
      SystemUi.statusBarForAllScreenExceptSplashScreen();

      expect(log, hasLength(1));
      final args = log.first.arguments as Map;
      expect(args['statusBarColor'], 0xFFF2F2F2);
      expect(args['statusBarIconBrightness'], 'Brightness.dark');
    });

    test('bottomActionBar sets nav bar and status bar styles', () async {
      SystemUi.bottomActionBar();

      expect(log, hasLength(1));
      final args = log.first.arguments as Map;

      expect(args['systemNavigationBarColor'], Colors.green.value);
      expect(args['systemNavigationBarIconBrightness'], 'Brightness.light');
      expect(args['statusBarColor'], 0xFFF2F2F2);
      expect(args['statusBarIconBrightness'], 'Brightness.dark');
    });
  });
}
