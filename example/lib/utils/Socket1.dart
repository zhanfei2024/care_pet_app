import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  const String path = 'wss://ws.ckudz.com/ws';
  final IOWebSocketChannel channel = IOWebSocketChannel.connect(path, headers: <String, dynamic>{
      'Origin': 'http://w.ckudz.com',
      'connection': 'Upgrade',
      'sec-websocket-key': '3LRD4zL+Uy+anc0GTCV06w==',
      'sec-websocket-protocol': 'chat',
      'sec-websocket-version': 13,
      'upgrade': 'websocket'
    });
      // channel.sink.add('received!');
  
  channel.stream.listen((dynamic message) {
    print(message);
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}



/* class Socket {
  WebSocket webSocket;
  

  void initSocket() {
    const String path = 'wss://ws.ckudz.com/ws';
    Future<WebSocket> future = WebSocket.connect(path, headers: <String, dynamic>{
      'Origin': 'http://w.ckudz.com',
      'connection': 'Upgrade',
      'sec-websocket-key': '3LRD4zL+Uy+anc0GTCV06w==',
      'sec-websocket-protocol': 'chat',
      'sec-websocket-version': 13,
      'upgrade': 'websocket'
    });
    
    future.then((WebSocket webSocket) {
      webSocket.listen((dynamic onData) {
        println('服务端==${onData}');
      }, onError: (dynamic err) {
        println('服务端==onerror${err}');
      }, onDone: () {
        println('服务端==ondone');
      });

    });
  }

  void sendMessage() {
    webSocket.add('hahha');
  }

  void close() {
  }
} */