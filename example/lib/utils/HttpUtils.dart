// ignore_for_file: avoid_classes_with_only_static_members
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sample/state_model/Res.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */

class HttpUtils {

  HttpUtils({this.apiPrefix, this.context});

  /// global dio object
  static Dio dio;

  /// default options
  String apiPrefix;
  String token;
  BuildContext context;
  
  static const int CONNECT_TIMEOUT = 20000;
  static const int RECEIVE_TIMEOUT = 10000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';


  Future<ResState> request({
    @required String url,
    Map<String, dynamic> param,
    Map<String, dynamic> data,
    @required String method,
  }) async {
    final ToastCustom toast = ToastCustom();
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    token = prefs.getString('token');
    token ??= '';
    final Dio dio = createInstance();
    try {
      developer.log(
        '请求url',
        name: 'http',
        error: url,
      );
      developer.log(
        '请求token',
        name: 'http',
        error: token,
      );
      developer.log(
        '请求参数param',
        name: 'http',
        error: param.toString(),
      );
      developer.log(
        '请求参数data',
        name: 'http',
        error: data.toString(),
      );

      final Response<dynamic> response = await dio.request<String>(url,
          queryParameters: param,
          data: data,
          options: Options(method: method));

      final dynamic result = json.decode(response.data);

      final ResState _response = ResState.fromJson(result);

      developer.log(
        '响应成功',
        name: 'http',
        error: response,
      );

      if(_response.code != 200) {
        toast.showCustomWidgetToast(msg: _response.msg.toString());
      }
      return _response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      final Response<dynamic> res = e.response;
      if(res == null) {
        toast.showCustomWidgetToast(msg: '连接服务器失败');
        return null;
      }
      final ResState _response = ResState.fromJson(json.decode(e.response.data));
      final int statusCode = e.response.statusCode;
      if(statusCode == 401) {
        toast.showCustomWidgetToast(msg: '你的登录信息已过期，请重新登录');
        final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        prefs.setString('token', null);
        prefs.setInt('userId', null);
        Navigator.of(context).pushNamed('login');
      } else {
        toast.showCustomWidgetToast(msg: _response.msg);
      }
      return _response;
    }
  }

  /// 创建 dio 实例对象
  Dio createInstance() {
    // if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      apiPrefix ??= 'http://192.168.1.100:8000'; // http 测试
      // apiPrefix ??= 'https://weapp.ckudz.cn'; // http 生产
      final BaseOptions option = BaseOptions(
          baseUrl: apiPrefix,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: <String, dynamic>{
            'user-agent': 'dio',
            'api': '1.0.0',
            'Accept': '*/*',
            'Connection': 'keep-alive',
            'content-type': 'json',
            'token': token
          },
          // contentType: 'json',
          // Transform the response data to a String encoded with UTF8.
          // The default value is [ResponseType.JSON].
          responseType: ResponseType.plain
      );
      dio = Dio(option);
    // }
    return dio;
  }

  /// 清空 dio 对象
  static void clear() {
    dio = null;
  }
}
