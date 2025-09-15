import 'package:flutter/material.dart';
import 'package:learn_getx_bloc_riverpod/chatApp/LoginAndRegister.dart';
import 'package:learn_getx_bloc_riverpod/chatApp/screens/chat_screen.dart';
import 'package:learn_getx_bloc_riverpod/chatApp/variable/globalVariable.dart';

class Initializes extends StatefulWidget {
  const Initializes({super.key});

  @override
  State<Initializes> createState() => _InitializesState();
}

class _InitializesState extends State<Initializes> {
  Future<void> loginOrRegister() async {
    final username = 'first3';
    final password = 'second';
    final result = await LoginAndRegister.login(
      username: username,
      password: password,
    );
    if (result["status"] == "success") {
      debugPrint('=========success========$result');
      GlobalVariable.navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChatScreen(userId: username, roomId: 'rek'),
        ),
      );
    } else {
      debugPrint('=======error===========$result');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginOrRegister();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.red)),
    );
  }
}
