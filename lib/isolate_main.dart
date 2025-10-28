import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/isolate/commute.dart';


void main() {
    runApp(IsolateFunction());
}


class IsolateFunction extends StatelessWidget {
  const IsolateFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CommuteApiScreen(),
    );
  }
}