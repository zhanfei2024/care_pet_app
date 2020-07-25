/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 04/02/2020
 * Copyright :  S.Hamblett
 */

/// mqtt_client现在已分为服务器客户端[MqttServerClient]和浏览器
/// 客户端[MqttBrowserClient]。这两个客户端的示例用法包含在此目录中。
/// 使用安全套接字的服务器客户端的用法示例位于iot_core.dart文件中。
/// 除了连接功能外，带有MQTT的客户端的行为是相同的。
/// 请注意，对于以前的用户，[MqttClient]类现在仅是支持类，不应
/// 直接实例化。
