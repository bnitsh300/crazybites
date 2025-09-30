import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoExample extends StatefulWidget {
  const SocketIoExample({Key? key}) : super(key: key);

  @override
  _SocketIoExampleState createState() => _SocketIoExampleState();
}

class _SocketIoExampleState extends State<SocketIoExample> {
  late IO.Socket socket;
  String receivedMessage = "";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _connectToServer() {
    socket = IO.io(
      "http://192.168.68.120:8080", 
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      debugPrint("✅ Connected to Server");
    });

    socket.onDisconnect((_) {
      debugPrint("❌ Disconnected from Server");
    });

    // Listen to messages
    socket.on("chatMessage", (data) {
      debugPrint("📩 Raw data: $data");

      setState(() {
        if (data is Map) {
          receivedMessage = "${data['name']}: ${data['message']}";
        } else if (data is String) {
          receivedMessage = data;
        } else {
          receivedMessage = data.toString();
        }
      });
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    socket.emit("chatMessage", {
      "name": "FlutterUser",
      "message": _controller.text.trim(),
    });

    _controller.clear();
  }

  @override
  void dispose() {
    socket.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Socket.IO Chat")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Received: $receivedMessage"),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Type a message",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
