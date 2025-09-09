import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/constants/global/globalContext.dart';
import 'package:learn_getx_bloc_riverpod/route/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Get Bloc RiverPod',
       debugShowCheckedModeBanner: false,
       key: Globalcontext.navigatorKey,
       theme: ThemeData(
         fontFamily: 'SFProDisplay', // Set default font family here
         scaffoldBackgroundColor: Colors.white,
         appBarTheme: const AppBarTheme(
           backgroundColor: Colors.white, // Set global AppBar color
         ),
         popupMenuTheme: const PopupMenuThemeData(
           color: Colors.white, // Set popup menu background color
           textStyle:
           TextStyle(color: Colors.black), // Set popup menu text color
         ),
       ),
      routerConfig: RouteApp.routes,
      // Remove these lines - they're included in routerConfig
      // routeInformationProvider: RouteApp.routes.routeInformationProvider,
      // routeInformationParser: RouteApp.routes.routeInformationParser,
      // routerDelegate: RouteApp.routes.routerDelegate,
    );
  }
}
