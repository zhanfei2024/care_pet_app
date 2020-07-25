import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample/common/dialog.dart';
import 'package:sample/state_model/customDialog.dart';


mixin NetWorkConnectMixin {

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity(BuildContext ctx) async {
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    /* if (!mounted) {
      return Future.value(null);
    } */

    return updateConnectionStatus(result, ctx);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result, BuildContext ctx) async {
    final Connectivity _connectivity = Connectivity();
    String _connectionStatus;
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = 'Failed to get Wifi Name';
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = 'Failed to get Wifi BSSID';
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = 'Failed to get Wifi IP';
        }

        /* /* _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n'; */
        toast.showCustomWidgetToast(msg: '已连接wifi'); */
        print('$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n');
        break;
      case ConnectivityResult.mobile:
        // toast.showCustomWidgetToast(msg: '已连接到蜂窝网络');
        break;
      case ConnectivityResult.none:
        _connectionStatus = '网络连接发生问题，请检查你的网络';
        break;
      default:
        _connectionStatus = '获取网络连接状态失败，请检查你的网络';
        break;
    }
    if (_connectionStatus != null) {
      final List<CustomDialogState>  options = <CustomDialogState>[
        CustomDialogState()
        ..icon = Icons.error_outline
        ..title = _connectionStatus
        ..value = 'yes'
      ];
      final String result = await CustomDialog.customDialog(ctx, options);
      if (result == 'yes') {
        Navigator.of(ctx).pushNamed('network_disconnect');
      }
    }
  }
}

class NetWorkConnect with NetWorkConnectMixin{

}