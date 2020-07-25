/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/010/2017
 * Copyright :  S.Hamblett
 *
 */

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

///连接到Google物联网核心MQTT桥服务器并发布到设备主题的示例。
///完整的安装说明可以在这里https://cloud.google.com/iot/docs/how-tos/mqtt-bridge，请阅读
///在设置和运行此示例之前。
Future<int> main() async {
  //创建并连接客户端
  const String url = 'zhanzijin.com'; // The google iot-core MQTT bridge server
  const int port = 8883; // You can also use 8883 if you so wish
  //客户端ID是您设备的路径，如下所示，请注意，这违反了23个字符的客户端ID长度
  //从MQTT规范开始，如果超过了mqtt_client且日志记录已打开，则mqtt_client会发出警告。
  const String clientId = 'iPhone 6p';
  //不使用用户名，并且可以将其设置为任何名称，因为密码字段包含设备的已编码JWT令牌，所以它是必需的
  const String username = 'unused';
  //密码包含已编码的JWT令牌，例如以下示例，生成时应使用私钥coresponding对JWT令牌进行编码
  //设置为设备的公钥。
  const String password = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDcyMTM0NzMsImlhdCI6MTUwNzIwOTg3MywiYXVkIjoid2FybS1hY3Rvci0zNTYifQ.NGLiu9svhI6BhGeodGfbBQGGRjiX4j-9bxQdWWYa_2LEjCHdbmDTQC6eHoDHf6nTMMADiQa3sKqD9cZ1gtdT-wfAzEqvJX1Hy5w0Ex8jqe_qidS8Iwtj1TVsvnlXr6OPyHuwW9hAcuOFdlNIXYqDyXDSFl--qa7HS1zqXEy9FMbg20Y8xNSMk1MLG22i8STvYrQmNfm-ib47WayUojllgy2ukMee_N67G2bXq91U3gU0YhlDX4_INjwSTaAtJ4p70Vvd21NFsVBaf0FdJAix5Zsdk165XXjLU6FsfOAzcdeiazzlPFTC-HvQ1eXz4BLn0AaMIFoOkwV9SgBuTdLX8IU3T2hKchtsNw4r5YJa8qw3hu-egsH8bHmSX1cVhjbdWHWihjOnJO_0ef8jWQ6K87Pwhjrc_mBaKo1REllvGV7bOgXoFXW2t1vnb4MtiC7ZpYo5bR9FUsbO_CVMNYHIld6YSmOeO6GCP7OF9kkhEeHGgIIFjsLiAQaqoTCm0EGTh8dTZoYnpv3mRrOw61BgTjPAFvP9OK0hDw4EWXwINoT1UTCQTXF1no_7TZn4wgy-Glx1RA_EGqgEuDSe77H5Oc0aQHj3c01mwlbHJxsmguhSWgdOdc1WPbXqYkJJhcQ-PUvCGuJL5Ut5500dBztdsYaVaRpReOstj0W-a2AF1nU';
  // 创建客户端
  final MqttServerClient client = MqttServerClient(url, clientId);
  // 设置端口
  client.port = port;
  // 设置安全
  client.secure = true;
  // 根据需要设置安全上下文，请注意，这是标准的Dart SecurityContext类。
  // 如果不正确，则TLS握手将中止，并且将引发Handshake异常，
  // 没有收到连接确认消息，并且代理将断开连接。
  final String currDir = '${path.current}${path.separator}example${path.separator}';
  final SecurityContext context = SecurityContext.defaultContext;
  context.setTrustedCertificates(currDir + path.join('pem', 'roots.pem'));
  // 如果需要，请设置私钥文件路径和可选密码以及任何其他受支持的安全功能
  // 注意，对于flutter用户，可以将以上参数设置为字节格式，而不是文件路径。
  client.securityContext = context;
  // 将iot-core的协议设置为V3.1.1，如果不这样做，您将收到带有响应代码的连接确认
  // 0x01连接被拒绝，协议版本不可接受
  client.setProtocolV311();
  // logging if you wish
  client.logging(on: true);
  // 好，如果密码字段中的已编码JWT令牌无法被附加的相应公钥解码，请连接
  // 到设备或JWT令牌不正确，将收到连接确认消息，返回码为
  // 0x05连接被拒绝，未经授权。如果根本没有设置密码字段，则返回码可能是
  // 0x04连接被拒绝，用户名或密码错误
  await client.connect(username, password);
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('客户端已连接');
  } else {
    print(
        'ERROR iotcore client connection failed - disconnecting, state is ${client.connectionStatus.state}');
    client.disconnect();
  }
  //故障排除提示可以在这里找到https://cloud.google.com/iot/docs/troubleshooting
  //发布到您与设备关联的主题
  const String topic = 'camera';
  // 在此处使用原始缓冲区，请参阅MqttClientPayloadBuilder获得有效负载构建帮助。
  final typed.Uint8Buffer buff = typed.Uint8Buffer(4);
  buff[0] = 'a'.codeUnitAt(0);
  buff[1] = 'b'.codeUnitAt(0);
  buff[2] = 'c'.codeUnitAt(0);
  buff[3] = 'd'.codeUnitAt(0);
  client.publishMessage(topic, MqttQos.exactlyOnce, buff);

  print('Sleeping....');
  await MqttUtilities.asyncSleep(10);
  print('Disconnecting');
  client.disconnect();
  return 0;
}
