import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'state.dart';

Widget buildView(
  ModifyPasswordState state, Dispatch dispatch, ViewService viewService) {
      final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('修改密码'),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
          alignment: Alignment.center,
            child: 
              Form(
                // key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidate: false, //开启自动校验
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        autofocus: false,
                        // controller: _receiptTitleController,
                        decoration: InputDecoration(
                            labelText: '旧密码:',
                            hintText: '您的旧密码',
                            icon: Icon(Icons.text_fields)
                        ),
                        validator: (String v) {
                          return v.trim().isNotEmpty == true
                              ? null
                              : '旧密码不能为空';
                        }),
                    TextFormField(
                        autofocus: false,
                        // controller: _taxpayerNumberController,
                        decoration: InputDecoration(
                            labelText: '新密码:',
                            hintText: '您的新密码',
                            icon: Icon(Icons.format_list_numbered)),
                        validator: (String v) {
                          return v.trim().isNotEmpty == true ? null : '新密码不能为空';
                        }),
                    TextFormField(
                        autofocus: false,
                        // controller: _emailController,
                        decoration: InputDecoration(
                            labelText: '确认密码:',
                            hintText: '您的确认密码',
                            icon: Icon(Icons.alternate_email)),
                        validator: (String v) {
                          return v.trim().isNotEmpty == true ? null : '确认密码不能为空';
                        }),
                    Container(
                      // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(100)),
                      width: ScreenUtil().setWidth(width),
                      height: ScreenUtil().setWidth(80),
                      child: Builder(builder: (dynamic context) {
                      return FlatButton(
                        // enabled: state.submiting,
                        // color: Colors.yellow_primary,
                        // disabledColor: Colors.grey_primary,
                        // disabledTextColor: CustomColor.primary1Color,
                        // highlightColor: CustomColor.linear2Color,
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        child: Text(
                          '保存',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {}
                      );
                    }))
                  ],
                ),
              ),
            ),
    )
  );
}
