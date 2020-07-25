import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';

import 'state.dart';

Widget buildView(ResetPasswordState state, Dispatch dispatch, ViewService viewService) {
  final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
  // final TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  return Scaffold(
      appBar: AppBar(
        title: const Text('找回密码'),
        bottom: Style.preferredSize,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
            alignment: Alignment.center,
            child: Form(
              // key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: false, //开启自动校验
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      autofocus: false,
                      // controller: _receiptTitleController,
                      decoration: InputDecoration(
                        labelText: '手机号',
                        hintText: '您的手机号码',
                        icon: Icon(Icons.phone_android),
                      ),
                      validator: (String v) {
                        return v.trim().isNotEmpty == true ? null : '手机号不能为空';
                      }),
                  TextFormField(
                      autofocus: false,
                      // controller: _taxpayerNumberController,
                      decoration: InputDecoration(
                          labelText: '验证码',
                          hintText: '您的验证码',
                          icon: Icon(Icons.message),
                          suffixIcon: FlatButton(
                            onPressed: () {},
                            child: const Text('发送验证码'),
                          ),
                      ),
                      validator: (String v) {
                        return v.trim().isNotEmpty == true ? null : '验证码不能为空';
                      }),
                  TextFormField(
                      autofocus: false,
                      // controller: _taxpayerNumberController,
                      decoration: InputDecoration(
                          labelText: '新密码',
                          hintText: '您的新密码',
                          icon: Icon(Icons.lock_outline)),
                      validator: (String v) {
                        return v.trim().isNotEmpty == true ? null : '新密码不能为空';
                      }),
                  Container(
                      // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setWidth(100), bottom: ScreenUtil().setWidth(40)),
                      width: ScreenUtil().setWidth(width),
                      child: Builder(builder: (dynamic context) {
                        return RaisedButton(
                            child: Text(
                              '确认',
                              style: Style.buttonTextStyle
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            onPressed: () {});
                      })),
                ],
              ),
            ),
          ),
      ));
}
