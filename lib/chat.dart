import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_getx_bloc_riverpod/chatApp/auth.dart';
import 'chatApp/screens/chat_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Chat",
      // home: ChatScreen(userId: "user1", roomId: "room1"),
      home: RegisterAndLoginAuth(),
    );
  }
}
