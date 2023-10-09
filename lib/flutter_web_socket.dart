import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FlutterWebSocket extends StatefulWidget {
  const FlutterWebSocket({Key? key}) : super(key: key);

  @override
  State<FlutterWebSocket> createState() => _FlutterWebSocketState();
}

class _FlutterWebSocketState extends State<FlutterWebSocket> {

  var channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('WebSocket'),
      ),
      body: Center(
        child: Column(children: [
          TextFormField(
            controller: _messageController,
          ),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {

                return Text('Error: ${snapshot.error}');

              }
              if (snapshot.hasData) {

                return Text('Received: ${snapshot.data}');

              }
              return const CircularProgressIndicator();
            },
          ),
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
        channel.sink.add(_messageController.text);
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
