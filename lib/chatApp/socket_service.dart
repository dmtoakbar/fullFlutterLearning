import 'package:learn_getx_bloc_riverpod/chatApp/variable/globalVariable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io(
      dotenv.env['SOCKET_URL']!,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'Authorization': 'Bearer ${GlobalVariable.authenticationToken}'})
          .disableAutoConnect()
          .setAuth({'token': GlobalVariable.authenticationToken})
          .build(),
    );


    socket.connect();

    socket.onConnect((_) {
      print("Connected: ${socket.id}");
      socket.emit("login", userId);
    });
  }

  void joinRoom(String roomId) {
    socket.emit("joinRoom", {"roomId": roomId});
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit("message", message);
  }

  void typing(String roomId, bool isTyping, String from) {
    socket.emit("typing", {"roomId": roomId, "isTyping": isTyping, "from": from});
  }

  void messageSeen(String messageId) {
    socket.emit("seen", {"messageId": messageId});
  }

  void onMessage(Function callback) {
    socket.on("message", (data) => callback(data));
  }

  void onTyping(Function callback) {
    socket.on("typing", (data) => callback(data));
  }

  void onSeen(Function callback) {
    socket.on("seen", (data) => callback(data));
  }

  void disconnect() {
    socket.disconnect();
  }
}
