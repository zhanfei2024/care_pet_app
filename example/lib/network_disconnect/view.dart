import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';
import './state.dart';

Widget buildView(
    NetWorkDisconnectState state, Dispatch dispatch, ViewService viewService) {
  final TextStyle bigTitle = TextStyle(color: Colors.black87, fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.w500);
  final TextStyle secondTitle = TextStyle(color: Colors.black87, fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.w500);
  final TextStyle content = TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w400);
  final TextStyle weightContent = TextStyle(color: Colors.black87, fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w600);
  
  Widget custom(Widget child) {
    return  Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12), horizontal: ScreenUtil().setWidth(10)),
          width: ScreenUtil().setWidth(12),
          height: ScreenUtil().setWidth(12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        Expanded(child: child,
        )
      ]
    );
  }
  
  return Scaffold(
    appBar: AppBar(
      title: const Text('未能连接到互联网'),
      bottom: Style.preferredSize,
    ),
    backgroundColor: Colors.grey[200],
    body: Stack(
      children: <Widget>[
        SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(26), horizontal: ScreenUtil().setWidth(26)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('你的设备未启用移动网络或无线局域网', style: bigTitle )
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(24)),
              child: Text('如需要连接到互联网，请参考以下方法:', style: secondTitle )
            ),
            custom(Text.rich(TextSpan(children: <InlineSpan>[
              TextSpan(text: '检查手机中的"', style: content),
              TextSpan(text: '设置-无线局域网', style: weightContent),
              TextSpan(text: '"是否开启，选择一个可用的网络接入。', style: content)
            ]))),
            custom(Text.rich(TextSpan(children: <InlineSpan>[
              TextSpan(text: '检查手机中的"', style: content),
              TextSpan(text: '设置-蜂窝移动网络', style: weightContent),
              TextSpan(text: '"是否开启，并且手机没有被停机（启用蜂窝移动网络后运营商可能会收取数据通讯费用）。', style: content)
            ])),),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(24)),
              child: Text('如果你已接入无线局域网：', style: secondTitle )
            ),
            custom(Text.rich(TextSpan(children: <InlineSpan>[
              TextSpan(text: '请检查你所连接的无线局域网热点是否已接入互联网，或该热点是否已允许你的设备访问互联网。', style: content)
            ])),),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(24)),
              child: Text('如果你的手机是iOS 10.x版本的系统：', style: secondTitle )
            ),
            custom(Text.rich(TextSpan(children: <InlineSpan>[
              TextSpan(text: '可以尝试到"', style: content),
              TextSpan(text: '设置-蜂窝移动网络-无线局域网助理', style: weightContent),
              TextSpan(text: '"里，主动切换下', style: content),
              TextSpan(text: '无线局域网助理', style: weightContent),
              TextSpan(text: '的开关后，再检查app是否可以正常访问网络。', style: content)
            ])),),
          ]
        ),
      )
    ),
      ]
    ) 
  );
}
