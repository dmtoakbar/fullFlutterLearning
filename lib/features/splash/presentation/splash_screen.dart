import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/features/system_ui/systemui.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {

    // in stateful class, you can put this function within initState
    // putting this here , main reason , stateless class
    SystemUi.statusBarForSplashScreen();

   return Scaffold(
     body: Center(child: Text('Home'),),
   );
  }
}





