// ignore_for_file: non_constant_identifier_names, avoid_as

import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sample/common/Style.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
  // final TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final  GlobalKey _formKey=  GlobalKey<FormState>();

  return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
        bottom: Style.preferredSize,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
          alignment: Alignment.center,
          child: Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            autovalidate: true, //开启自动校验
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
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
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: '密码',
                        hintText: '您的密码',
                        icon: Icon(Icons.lock_outline),
                        suffixIcon: state.showPassword == true ? IconButton(
                          icon: Style.svg('assets/svgs/icon-miwen.svg'),
                          onPressed: () {

                          },
                        ) : IconButton(
                          icon: Style.svg('assets/svgs/icon-icon_yulan.svg'),
                          onPressed: () {

                          },
                        )
                        ),
                    obscureText: state.showPassword,
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '密码不能为空';
                    }),
                FormField<dynamic>(
                  builder: (FormFieldState<dynamic> field) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: ScreenUtil().setWidth(50),
                        ),
                        Radio<dynamic>(
                          // activeColor: Colors.yellow_primary,
                          value: 1,
                          groupValue: 1,
                          onChanged: (dynamic value) {
                           
                          },
                        ),
                        Text.rich(TextSpan(children: <TextSpan>[
                          const TextSpan(text: '已阅读并同意'),
                          TextSpan(
                            text: '《用户服务协议》',
                            style: TextStyle(color: Colors.blue),
                            // recognizer: _tapRecognizer
                          ),
                        ]))
                      ],
                    );
                  },
                ),
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
                          onPressed: () {
                            if((_formKey.currentState as FormState).validate()){
                              //验证通过提交数据
                              dispatch(RegisterActionCreator.onSubmitAction(<String, dynamic>{
                                'username': _phoneController.text, 
                                'password': _passwordController.text,
                              }));
                            }
                          });
                    })),
              ],
            ),
          ),
        ),
      ),
    );
}
