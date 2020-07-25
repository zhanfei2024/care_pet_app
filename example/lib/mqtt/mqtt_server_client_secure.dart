/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 20/03/2020
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sample/global_store/action.dart';
import 'package:sample/global_store/store.dart';
import 'package:sample/gps_util/GpsUtil.dart';

///带注释的安全mqtt_server_client的简单订阅/发布用法示例。请参考阅读
///符合MQTT规范。该示例是可运行的，另请参阅test / mqtt_client_broker_test ... dart
///用于单独的订阅/发布测试的文件。

///首先创建一个客户端，该客户端由代理名称，客户端标识符构成
///和端口（如果需要）。客户端标识符（简称ClientId）是每个MQTT的标识符
///客户端连接到MQTT代理。正如标识符一词已经暗示的那样，每个经纪人应该是唯一的。
///代理使用它来识别客户端和客户端的当前状态。如果您不需要状态
///由代理持有，在MQTT 3.1.1中，您可以设置一个空的ClientId，这将导致连接没有任何状态。
///条件是干净会话连接标志为true，否则连接将被拒绝。
///客户端标识符的最大长度为23个字符。

final MqttServerClient client = MqttServerClient('119.23.26.180', '');

Future<int> main() async {
  /// 如果需要，设置登录，默认为关闭
  client.logging(on: false);

  ///设置安全工作
  client.secure = true;
  
  //设置端口
  client.port = 8883; // mosquitto的安全端口号，不需要客户端证书

  /// 安全上下文
  // print(path.current);
  // final String currDir = '${path.current}${path.separator}example/lib/mqtt${path.separator}';
  final SecurityContext context = SecurityContext.defaultContext;
  // context.setTrustedCertificates(currDir + path.join('pem', 'mosquitto.org.crt'));
  final String cerData = await rootBundle.loadString('assets/ca.crt');
  final String clientCrtData = await rootBundle.loadString('assets/client.crt');
  final String clientKeyData = await rootBundle.loadString('assets/client.key');
  final List<int> certBytes = utf8.encode(cerData);
  final List<int> clientCrtBytes = utf8.encode(clientCrtData);
  final List<int> clientKeyBytes = utf8.encode(clientKeyData);
  

  context.setTrustedCertificatesBytes(certBytes);
  context.useCertificateChainBytes(clientCrtBytes);
  context.usePrivateKeyBytes(clientKeyBytes);

  ///如果您打算在连接消息中使用保持活动的值，而不是默认值（60s）
  ///您必须在这里设置
  client.keepAlivePeriod = 20;

  ///添加未经请求的断开回调
  client.onDisconnected = onDisconnected;

  ///添加成功的连接回调
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

  ///设置错误证书上的回调，请注意该参数是必需的。
  client.onBadCertificate = (dynamic a) => true;

  ///创建要使用的连接消息或使用默认消息。默认设置为
  ///客户端标识符，提供的任何用户名/密码，默认的keepalive间隔（60s）
  ///和clean session，下面是特定会话的示例。
  final MqttConnectMessage connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .keepAliveFor(20) // Must agree with the keep alive set above or not set
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
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

  ///检查是否已连接
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('EXAMPLE::mqtt 客户端已连接');
  } else {
    ///在这里使用status而不是在您还希望经纪人返回代码的情况下声明。
    print(
        'EXAMPLE::错误 mqtt 客户端连接失败 - 断开, status is ${client.connectionStatus}');
    client.disconnect();
    exit(-1);
  }

  ///好的，让我们尝试订阅
  print('EXAMPLE::订阅主题 ');
  const String topic = '/push/test/862285036158503'; // Not a wildcard topic
  client.subscribe(topic, MqttQos.atMostOnce);

  ///客户端有一个更改通知程序对象（请参见Observable类），然后我们通过监听该对象来获取
  ///有关每个订阅主题的已发布更新的通知。
  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttPublishMessage recMess = c[0].payload;
    final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    ///对于只对
    ///但是，一些用户可能对接收到的发布消息感兴趣，
    ///我们不要拘束自己，直到这个包裹在野外
    ///一段时间。
    ///有效负载是一个字节缓冲区，这将特定于主题
    print('EXAMPLE::变更通知:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    final List<String> latLng = pt?.split(',');
    if(latLng?.isNotEmpty == true && latLng?.length == 2 ) {
      final LatLng location = GpsUtil.gps84ToGcj02(double.parse(latLng[0]), double.parse(latLng[1]));
      GlobalStore.store.dispatch(GlobalActionCreator.onchangeCurrentLocation(location));
    }
  });

  ///对于仅对以下内容感兴趣的用户，上面的内容似乎有些令人费解
  ///有效负载，但是某些用户可能会对收到的发布消息感兴趣，
  ///直到程序包狂野起来之前，不要束缚自己
  /// 一阵子。
  ///有效负载是字节缓冲区，这将特定于主题
  client.published.listen((MqttPublishMessage message) {
    print('EXAMPLE::已发布通知:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  });

  
  ///让我们发布到我们的主题
  ///使用有效负载生成器而不是原始缓冲区
  ///我们已知的主题要发布到
  const String pubTopic = '/subscribe/test/862285036158503';
  final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  builder.addString('ok');

  /// 订阅它
  print('EXAMPLE::订阅 /subscribe/test/862285036158503 主题');
  client.subscribe(pubTopic, MqttQos.exactlyOnce);

  /// 发布它
  print('EXAMPLE::发布我们的主题');
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);

  ///好的，我们现在要睡一会儿，在这个间隙中，您将看到ping请求/响应
  ///保持活动机制正在交换消息。
  print('EXAMPLE::睡眠....');
  await MqttUtilities.asyncSleep(120);

  /// 最后，退订并优雅退出
  print('EXAMPLE::退订');
  client.unsubscribe(topic);

  /// 如果您愿意，请等待来自代理的取消订阅消息。
  await MqttUtilities.asyncSleep(2);
  print('EXAMPLE::断开连接');
  client.disconnect();
  return 0;
}

/// The subscribed callback
void onSubscribed(String topic) {
  print('EXAMPLE::已确认订阅主题 $topic');
}

/// The unsolicited disconnect callback
void onDisconnected() {
  print('EXAMPLE::未连接的客户端回调 - 客户端断开连接');
  if (client.connectionStatus.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    print('EXAMPLE::已请求断开连接的回调，这是正确的');
  }
  exit(-1);
}

/// The successful connect callback
void onConnected() {
  print('EXAMPLE::连接的客户端回调 - 客户端连接成功');
}

/// Pong callback
void pong() {
  print('EXAMPLE::调用Ping响应客户端回调');
}
