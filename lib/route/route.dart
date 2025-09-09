import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_getx_bloc_riverpod/features/paint/first.dart';
import 'package:learn_getx_bloc_riverpod/features/paint/second.dart';
import 'package:learn_getx_bloc_riverpod/features/paint/snake_game.dart';
import 'package:learn_getx_bloc_riverpod/features/paint/third.dart';
import 'package:learn_getx_bloc_riverpod/features/splash/presentation/splash_screen.dart';
import 'package:learn_getx_bloc_riverpod/route/route_name.dart';
import '../features/error/presentation/notFound/not_found.dart';

class RouteApp {
  static GoRouter routes = GoRouter(
    initialLocation: RouteName.paintSnakeGame,
    routes: <GoRoute>[
      route(path: RouteName.splash, page: const SplashScreen()),
      route(path: RouteName.paintFirst, page: CustomPainFirst()),
      route(path: RouteName.paintSecond, page: CustomPainSecond()),
      route(path: RouteName.paintThird, page: CustomPaintThird()),
      route(path: RouteName.paintSnakeGame, page: SnakeGamePage()),
    ],
    errorBuilder: (_, __) => const NotFound(),
    // Optional: Add redirect logic
    redirect: (BuildContext context, GoRouterState state) {
      // Add your authentication/redirect logic here
      // return null to proceed with current route
      // return path string to redirect
      return null;
    },
  );

  static GoRoute route({required String path, required Widget page}) {
    return GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) => page,
    );
  }

  // BASIC NAVIGATION METHODS

  /// Navigate to a new page (adds to navigation stack)
  static void launch(BuildContext context, String route, [Object? extra]) {
    GoRouter.of(context).push(route, extra: extra);
  }

  /// Navigate to a new page with replacement (no back arrow)
  static void replace(BuildContext context, String route, [Object? extra]) {
    GoRouter.of(context).replace(route, extra: extra);
  }

  /// Navigate to a new page with replacement (with back arrow)
  static void launchReplace(
    BuildContext context,
    String route, [
    Object? extra,
  ]) {
    GoRouter.of(context).pushReplacement(route, extra: extra);
  }

  /// Go back to previous page
  static void finish(BuildContext context) => GoRouter.of(context).pop();

  // ADVANCED NAVIGATION METHODS

  /// Navigate and remove all previous routes
  static void launchAndRemoveAll(
    BuildContext context,
    String route, [
    Object? extra,
  ]) {
    GoRouter.of(context).go(route, extra: extra);
  }

  /// Navigate and remove until a specific route
  static void launchAndRemoveUntil(
    BuildContext context,
    String newRoute,
    bool Function(Route<dynamic>) predicate, [
    Object? extra,
  ]) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => _getPageFromRoute(newRoute)),
      predicate,
    );
  }

  /// Pop until a specific route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil((route) => route.settings.name == routeName);
  }

  /// Check if can pop
  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  /// Get current route state
  static GoRouterState currentState(BuildContext context) {
    return GoRouter.of(context).routerDelegate.currentConfiguration
        as GoRouterState;
  }

  // PARAMETER HANDLING METHODS

  /// Navigate with query parameters
  static void launchWithParams(
    BuildContext context,
    String route,
    Map<String, String> queryParams, [
    Object? extra,
  ]) {
    final location = Uri(path: route, queryParameters: queryParams).toString();
    GoRouter.of(context).push(location, extra: extra);
  }

  /// Navigate with path parameters
  static void launchWithPathParams(
    BuildContext context,
    String baseRoute,
    Map<String, String> pathParams, [
    Object? extra,
  ]) {
    String routeWithParams = baseRoute;
    pathParams.forEach((key, value) {
      routeWithParams = routeWithParams.replaceFirst(':$key', value);
    });
    GoRouter.of(context).push(routeWithParams, extra: extra);
  }

  // ROUTE GUARDS AND VALIDATION

  /// Add route guard (example - authentication check)
  static Future<bool> requireAuth(BuildContext context) async {
    // Implement your authentication check logic
    // final authState = context.read<AuthProvider>().state;
    // return authState.isAuthenticated;
    return true; // Replace with actual check
  }

  /// Route validation method
  static bool isValidRoute(String route) {
    final validRoutes = [
      RouteName.splash,
      RouteName.paintFirst,
      RouteName.paintSecond,
      RouteName.paintThird,
    ];
    return validRoutes.contains(route);
  }

  // HELPER METHODS

  /// Get page widget from route name (for direct Navigator usage)
  static Widget _getPageFromRoute(String route) {
    switch (route) {
      case RouteName.splash:
        return const SplashScreen();
      case RouteName.paintFirst:
        return CustomPainFirst();
      case RouteName.paintSecond:
        return CustomPainSecond();
      case RouteName.paintThird:
        return CustomPaintThird();
      default:
        return const NotFound();
    }
  }

  /// Parse path parameters from current route
  static Map<String, String> getPathParams(BuildContext context) {
    final state = GoRouter.of(context).routerDelegate.currentConfiguration;
    if (state is GoRouterState) {
      return state.pathParameters;
    }
    return {};
  }

  // DEEPLINK HANDLING

  /// Handle deep links
  static void handleDeepLink(BuildContext context, String deepLink) {
    if (isValidRoute(deepLink)) {
      launchAndRemoveAll(context, deepLink);
    } else {
      // Handle invalid deep link
      launchReplace(context, RouteName.splash);
    }
  }
}

// Extension for easier route access
extension RouteExtensions on BuildContext {
  void pushRoute(String route, [Object? extra]) =>
      RouteApp.launch(this, route, extra);
  void replaceRoute(String route, [Object? extra]) =>
      RouteApp.replace(this, route, extra);
  void pushReplacementRoute(String route, [Object? extra]) =>
      RouteApp.launchReplace(this, route, extra);
  void goRoute(String route, [Object? extra]) =>
      RouteApp.launchAndRemoveAll(this, route, extra);
  void popRoute() => RouteApp.finish(this);
  bool get canPopRoute => RouteApp.canPop(this);
}

// example
/*
        // Using extension methods
        context.pushRoute(RouteName.paintFirst);

        // Or using the static methods directly
        RouteApp.launch(context, RouteName.paintSecond);
        // Basic navigation
RouteApp.launch(context, RouteName.paintFirst);

// With parameters
RouteApp.launchWithParams(context, RouteName.paintFirst, {'id': '123'});

// Remove all previous routes
RouteApp.launchAndRemoveAll(context, RouteName.splash);

// Using extensions
context.pushRoute(RouteName.paintSecond);
context.goRoute(RouteName.paintThird); // clear stack
 */
