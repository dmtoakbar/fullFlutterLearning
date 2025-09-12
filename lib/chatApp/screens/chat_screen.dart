import 'package:flutter/material.dart';
import '../socket_service.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String roomId;

  ChatScreen({required this.userId, required this.roomId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SocketService socketService = SocketService();
  final TextEditingController controller = TextEditingController();
  List messages = [];
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    socketService.connect(widget.userId);
    socketService.joinRoom(widget.roomId);

    socketService.onMessage((data) {
      setState(() => messages.add(data));
      socketService.messageSeen(data['id']); // mark as seen
    });

    socketService.onTyping((data) {
      print("${data['from']} is typing: ${data['isTyping']}");
      setState(() => isTyping = data['isTyping']);
    });

    socketService.onSeen((data) {
      print("Message seen: ${data['message']['id']}");
    });
  }

  void sendMessage() {
    final text = controller.text;
    if (text.isEmpty) return;

    socketService.sendMessage({
      "from": widget.userId,
      "roomId": widget.roomId,
      "text": text,
    });
    controller.clear();
  }

  void pickFileAndSend() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   File file = File(result.files.single.path!);
    //   var request = http.MultipartRequest(
    //       "POST", Uri.parse("${dotenv.env['API_URL']}/upload"));
    //   request.files.add(await http.MultipartFile.fromPath('file', file.path));
    //   var response = await request.send();
    //   if (response.statusCode == 200) {
    //     // Send media message
    //     socketService.sendMessage({
    //       "from": widget.userId,
    //       "roomId": widget.roomId,
    //       "media": "${dotenv.env['API_URL']}/uploads/${result.files.single.name}"
    //     });
    //   }
    // }
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Room")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  title: Text(msg['from']),
                  subtitle: msg['text'] != null
                      ? Text(msg['text'])
                      : msg['media'] != null
                      ? Image.network(msg['media'])
                      : null,
                );
              },
            ),
          ),
          if (isTyping) Text("Typing..."),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.attach_file),
                onPressed: pickFileAndSend,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (text) =>
                      socketService.typing(widget.roomId, text.isNotEmpty, widget.userId),
                  decoration: InputDecoration(hintText: "Type a message"),
                ),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: sendMessage)
            ],
          ),
        ],
      ),
    );
  }
}
