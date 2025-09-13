import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_getx_bloc_riverpod/route/route.dart';


// for traditional routing
class Globalcontext {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}

/*
 navigatorKey: GlobalConstant.navigatorKey,
 */

// for go_router
// global_context.dart
class GlobalContext {
  static BuildContext? _currentContext;

  // Call this in your root widget to set the context
  static void setContext(BuildContext context) {
    _currentContext = context;
  }

  static BuildContext? get context => _currentContext;

  static void push(String route, [Object? extra]) {
    if (_currentContext != null && _currentContext!.mounted) {
      GoRouter.of(_currentContext!).push(route, extra: extra);
    }
  }

  static void go(String route, [Object? extra]) {
    if (_currentContext != null && _currentContext!.mounted) {
      GoRouter.of(_currentContext!).go(route, extra: extra);
    }
  }

  static void pop() {
    if (_currentContext != null && _currentContext!.mounted) {
      GoRouter.of(_currentContext!).pop();
    }
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteApp.routes,
      builder: (context, child) {
        // Set the global context
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GlobalContext.setContext(context);
        });
        return child!;
      },
      title: 'Get Bloc RiverPod',
      debugShowCheckedModeBanner: false,
    );
  }
}



// more example
  GlobalVariable.navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => ChatScreen(userId: 'first', roomId: username),
      ),
    );


    GlobalVariable.navigatorKey.currentState?.pop(); // Go back if fails

    NavigationService.pushReplacement(
      ChatScreen(userId: 'first', roomId: username),
    );
