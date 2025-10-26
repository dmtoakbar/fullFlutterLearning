import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/practice/apiCall/apiIntragrationAndshowloading.dart';

void main () {
  runApp(PracticeSession());
}


class PracticeSession extends StatelessWidget {
  const PracticeSession({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: APICall(),
    );
  }
}
