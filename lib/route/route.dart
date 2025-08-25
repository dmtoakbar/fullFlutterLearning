import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_getx_bloc_riverpod/features/splash/presentation/splash_screen.dart';
import 'package:learn_getx_bloc_riverpod/route/route_name.dart';
import '../features/error/presentation/notFound/not_found.dart';

class RouteApp {

  static GoRouter routes = GoRouter(
    initialLocation: RouteName.splash,
      routes: <GoRoute>[
        route(path: RouteName.splash,
            page: const SplashScreen()
        ),
      ],
      errorBuilder: (_, _) => NotFound()
  );


  static GoRoute route ({required String path, required Widget page}) {
    return GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) => page,
    );
  }

}


