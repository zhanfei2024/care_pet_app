/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 31/05/2017
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

///带注释的mqtt_server_client的简单订阅/发布用法示例。请参考阅读
///符合MQTT规范。该示例是可运行的，另请参阅test / mqtt_client_broker_test ... dart
///用于单独的订阅/发布测试的文件。

///首先创建一个客户端，该客户端由代理名称，客户端标识符构成
///和端口（如果需要）。客户端标识符（简称ClientId）是每个MQTT的标识符
///客户端连接到MQTT代理。正如标识符一词已经暗示的那样，每个经纪人应该是唯一的。
///代理使用它来识别客户端和客户端的当前状态。如果您不需要状态
///由代理持有，在MQTT 3.1.1中，您可以设置一个空的ClientId，这将导致连接没有任何状态。
///条件是干净会话连接标志为true，否则连接将被拒绝。
///客户端标识符的最大长度为23个字符。如果未指定端口，则为标准端口
///使用1883。
///如果要使用websockets而不是TCP，请参见下文。

///为了测试自动重新连接功能，此示例使用在本地主机上运行的Mosquitto代理，
///只要您可以中断它与此过程的连接。您可以等待第一个pong回调打印出来
///（每5秒钟一次），然后停止/断开与服务器的连接并恢复它。
///
final MqttServerClient client = MqttServerClient('zhanzijin.com', '');

Future<int> main() async {
  /// Websocket URL必须以ws：//或wss：//开头，否则Dart会抛出异常，请咨询您的Websocket MQTT代理
  ///了解详情。
  ///要使用websocket，请添加以下几行-：
  /// client.useWebSocket = true;
  /// client.port = 80; （或您的WS端口是什么）
  ///还有一个供专家使用的备用websocket实现，请参见useAlternateWebSocketImplementation
  ///请注意，如果您使用的是wss，请不要设置安全标志，安全标志仅适用于TCP套接字。
  ///您还可以提供自己的websocket协议列表或使用websocketProtocols禁用此功能
  ///设置器，请在此处阅读API文档以获取更多详细信息，绝大多数代理将支持客户端默认设置
  ///列出，因此在大多数情况下，您可以忽略它。

  ///如果需要，请设置为登录，默认为关闭
  client.logging(on: true);

  ///如果您打算在连接消息中使用保持活动的值，而不是默认值（60s）
  ///您必须在这里设置
  client.keepAlivePeriod = 5;

  ///设置自动重新连接
  client.autoReconnect = true;

  /// Add the unsolicited auto reconnect callback
  client.onAutoReconnect = onAutoReconnect;

  
  ///添加未经请求的自动重新连接回调
  client.onConnected = onConnected;

  ///添加一个已订阅的回调，如果需要，还有一个未订阅的回调。
  ///您可以在连接前添加它们，或者在连接后动态更改它们，如果
  /// 你希望。对于失败的订阅，还有一个onSubscribeFail回调，这些
  ///可能由于您尝试订阅无效的主题或代理而失败
  ///拒绝订阅请求。
  client.onSubscribed = onSubscribed;

  ///如果需要，请设置一个ping接收的回调，每当收到ping响应（pong）时调用
  ///来自经纪人。
  client.pongCallback = pong;

  
  ///创建要使用的连接消息或使用默认消息。默认设置为
  ///客户端标识符，提供的任何用户名/密码，默认的keepalive间隔（60s）
  ///和clean session，下面是特定会话的示例。
  final MqttConnectMessage connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .keepAliveFor(5) // 必须同意以上设置的保持活动状态或未设置
      .withWillTopic('willtopic') // 如果您设置了此选项，则必须设置一个遗嘱消息
      .withWillMessage('My Will message')
      .startClean() // 非持久会话进行测试
      .withWillQos(MqttQos.atLeastOnce);
  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;

  ///连接客户端，通过引发适当的异常传达此处的任何错误。注意
  ///在某些情况下，经纪人只会断开我们的联系，请参阅有关此规范，但我们会
  ///永远不要发送格式错误的消息。
  try {
    await client.connect();
  } on Exception catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  }

  /// 检查我们是否已连接
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    /// 如果您还希望代理返回代码，请在此处使用status而不是state
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    exit(-1);
  }

  /// 好，让我们尝试订阅
  print('EXAMPLE::Subscribing to the test/lol topic');
  const String topic = 'test/lol'; // 不是通配符主题
  client.subscribe(topic, MqttQos.atMostOnce);

  /// 客户端有一个更改通知程序对象（请参见Observable类），然后我们通过监听该对象来获取
  /// 每个订阅主题的已发布更新的通知。
  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttPublishMessage recMess = c[0].payload;
    final String pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// 对于仅对以下内容感兴趣的用户，以上内容似乎有些令人费解
    /// 有效负载，但是某些用户可能会对收到的发布消息感兴趣，
    /// 让我们在包装狂野之前不要束缚自己
    /// for a while.
    /// 有效负载是一个字节缓冲区，这将特定于主题
    print(
        'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    print('');
  });

  //如果需要，您可以收听已完成发布的已发布消息
  ///取决于Qos的握手。此流上收到的任何消息均已完成其
  ///与代理发布握手。
  client.published.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  });

  ///让我们发布到我们的主题
  ///使用有效负载生成器而不是原始缓冲区
  ///我们已知的主题要发布到
  const String pubTopic = 'Dart/Mqtt_client/testtopic';
  final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  builder.addString('Hello from mqtt_client');

  
  ///订阅它 
  print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  client.subscribe(pubTopic, MqttQos.exactlyOnce);

  /// 发布它
  print('EXAMPLE::Publishing our topic');
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);

  //好的，我们现在要睡一会儿，在这个间隙中，您将看到ping请求/响应
  ///保持活动机制正在交换消息。
  print('EXAMPLE::Sleeping....');
  await MqttUtilities.asyncSleep(120);

  ///最后，退订并正常退出
  print('EXAMPLE::Unsubscribing');
  client.unsubscribe(topic);

  ///如果愿意，请等待来自代理的退订消息。
  await MqttUtilities.asyncSleep(2);
  print('EXAMPLE::Disconnecting');
  client.disconnect();
  return 0;
}

///订阅的回调
void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

///未经请求的断开回调
void onAutoReconnect() {
  print(
      'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
}

///成功的连接回调
void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was sucessful');
}

/// Pong回调
void pong() {
  print('EXAMPLE::Ping response client callback invoked - you may want to disconnect your broker here');
}
