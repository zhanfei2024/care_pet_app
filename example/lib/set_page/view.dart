import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';
import 'package:sample/utils/Navigate.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
  SetState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
  return Scaffold(
    appBar: AppBar(title: const Text('设置'), bottom: Style.preferredSize,),
    body: SingleChildScrollView(
      child: Container(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: Column(
          children: <Widget>[
            ListTile(
              dense: true,
              leading: Icon(Icons.security),
              title: const Text('用户协议'),
              subtitle: const Text('v1.0.0'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(viewService.context).pushNamed('user_agreement');
              },
            ),
            const Divider(height: 1,),
            ListTile(
              dense: true,
              leading: Icon(Icons.cloud_download),
              title: const Text('版本升级'),
              subtitle: const Text('v1.0.0'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // if (Platform.isAndroid) {
                  // dispatch(SettingActionCreator.onUpgradeAction());
                // } else if(Platform.isIOS) {
                  Navigate.launchURL('https://apps.apple.com/cn/app/%E8%BD%A6%E5%BA%93%E7%94%B5%E6%A1%A9/id1509391109');
                // }
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.phone_android),
              title: const Text('联系我们'),
              subtitle: const Text('18566290366'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigate.launchURL('tel:18566290366');
              },
            ),
          ]
        ),
        ) 
      )
    ),
    bottomNavigationBar: Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(40), horizontal: ScreenUtil().setWidth(40)),
      width: ScreenUtil().setWidth(width),
      child: Builder(builder: (dynamic context) {
        return RaisedButton(
          child: Text(
            '退出登录',
            style: Style.buttonTextStyle
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0)),
          onPressed: () {
            dispatch(SetActionCreator.onLogoutAction());
        });
      })),
  ); 
}
