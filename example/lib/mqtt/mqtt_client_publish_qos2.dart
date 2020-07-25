/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/09/2018
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// A QOS2 publishing example, two QOS two topics are subscribed to and published in quick succession,
/// tests QOS2 protocol handling.
Future<int> main() async {
  // final client = MqttServerClient('test.mosquitto.org', '');
  final MqttServerClient client = MqttServerClient('zhanzijin.com', '');
  client.logging(on: true);
  client.keepAlivePeriod = 20;
  client.onDisconnected = onDisconnected;
  client.onSubscribed = onSubscribed;
  final MqttConnectMessage connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueIdQ2')
      .keepAliveFor(20) // Must agree with the keep alive set above or not set
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce); // QOS级别1-保证消息的传递。它将至少传递一次，但如果发生网络错误，则可能传递多次。
  print('客户端连接中....');
  client.connectionMessage = connMess;

  try {
    await client.connect();
  } on Exception catch (e) {
    print('客户端异常 - $e');
    client.disconnect();
  }

  /// Check we are connected
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('客户端已连接上代理服务器');
  } else {
    print(
        '客户端连接代理服务器出错, 状态： ${client.connectionStatus.state}');
    client.disconnect();
    exit(-1);
  }

  /// Lets try our subscriptions
  print('订阅主题 1');
  const String topic1 = 'top1'; // Not a wildcard topic
  client.subscribe(topic1, MqttQos.exactlyOnce);
  print('订阅主题 2');
  const String topic2 = 'top2'; // Not a wildcard topic
  client.subscribe(topic2, MqttQos.exactlyOnce);

  // ignore: avoid_annotating_with_dynamic
  client.updates.listen((dynamic c) {
    final MqttPublishMessage recMess = c[0].payload;
    final String pt =  MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('变更通知: 主题 <${c[0].topic}>,  有效载荷 <-- $pt -->');
    print('');
  });

  /// 如果需要，您可以侦听已完成发布的已发布
  /// 握手，取决于Qos。在此流上接收到的任何消息都已完成其
  /// 发布与代理服务器的握手。
  // ignore: avoid_types_on_closure_parameters
  client.published.listen((MqttPublishMessage message) {
    print(
        '已发布通知:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  });

  final MqttClientPayloadBuilder builder1 = MqttClientPayloadBuilder();
  builder1.addString('Hello from mqtt_client topic 1');
  print('发布 1>');
  client.publishMessage(topic1, MqttQos.exactlyOnce, builder1.payload);

  final MqttClientPayloadBuilder builder2 = MqttClientPayloadBuilder();
  builder2.addString('Hello from mqtt_client topic 2');
  print('发布 2');
  client.publishMessage(topic2, MqttQos.exactlyOnce, builder2.payload);

  print('睡眠60秒');
  await MqttUtilities.asyncSleep(60);

  print('取消订阅主题');
  client.unsubscribe(topic1);
  client.unsubscribe(topic2);

  print('睡眠2秒');
  await MqttUtilities.asyncSleep(2);
  print('客户端和代理服务器断开');
  client.disconnect();
  return 0;
}

/// 订阅回调
void onSubscribed(String topic) {
  print('已确认订阅主题 $topic');
}

/// 主动断开连接回调
void onDisconnected() {
  print('客户端主动断开连接');
  exit(-1);
}
