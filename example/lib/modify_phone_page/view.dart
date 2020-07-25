import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'state.dart';

Widget buildView(
  ModifyPhoneState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('修改手机'),
      centerTitle: true,
    ),
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints.expand(height: 400),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: 0,
          steps: <Step>[
            Step(
              title: const Text('验证原号码'),
              isActive: true,
              content:Container(
              alignment: Alignment.center,
                child: 
                  Form(
                    // key: _formKey, //设置globalKey，用于后面获取FormState
                    autovalidate: false, //开启自动校验
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            autofocus: false,
                            // controller: _emailController,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: '18566290366',
                                hintText: '您的新手机号',
                                icon: Icon(Icons.phone_android),
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
                            // controller: _emailController,
                            decoration: InputDecoration(
                                labelText: '请输入验证码:',
                                hintText: '您的验证码',
                                icon: Icon(Icons.alternate_email)),
                            validator: (String v) {
                              return v.trim().isNotEmpty == true ? null : '验证码不能为空';
                            }),
                      ],
                    ),
                  ),
            )
            ),
            Step(
              title: const Text('绑定新手机'),
              content: Container(
              // padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              alignment: Alignment.center,
                child: 
                  Form(
                    // key: _formKey, //设置globalKey，用于后面获取FormState
                    autovalidate: false, //开启自动校验
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            autofocus: false,
                            // controller: _emailController,
                            decoration: InputDecoration(
                                labelText: '新手机号:',
                                hintText: '您的新手机号',
                                icon: Icon(Icons.phone_android),
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
                            // controller: _emailController,
                            decoration: InputDecoration(
                                labelText: '验证码:',
                                hintText: '您的验证码',
                                icon: Icon(Icons.message)),
                            validator: (String v) {
                              return v.trim().isNotEmpty == true ? null : '验证码不能为空';
                            }),
                      ],
                    ),
                  ),
            )
            )
          ],
          controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Container(
              // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(100)),
              width: ScreenUtil().setWidth(400),
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
                  '确定',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {}
              );
            }));
          },
          ),
      )
      
    ) 
  );
}
