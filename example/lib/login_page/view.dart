// ignore_for_file: non_constant_identifier_names, avoid_as

import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sample/common/Style.dart';
import 'package:sample/utils/Adapt.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
  final TapGestureRecognizer _tapGestureRecognizerOfCreateAccount = TapGestureRecognizer();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  final TextEditingController _phoneController = TextEditingController(text: state.username);
  final FocusNode _phoneFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController(text: state.password);
  final  GlobalKey _formKey= GlobalKey<FormState>();
  return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            brightness: Brightness.light,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Colors.red,
                constraints: const BoxConstraints.expand(height: 300),
                child: Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
                alignment: Alignment.center,
                child: Form(
                  key: _formKey, //设置globalKey，用于后面获取FormState
                  autovalidate: true, //开启自动校验
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(_phoneController.text),
                      SizedBox(
                        height: ScreenUtil().setWidth(40)
                      ),
                      Stack(
                        children: <Widget>[
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            focusNode: _phoneFocusNode,
                            decoration: InputDecoration(
                              labelText: '手机号码',
                              hintText: '您的手机号码',
                              icon: Icon(Icons.phone_android),
                            ),
                            validator: (String v) {
                              return v.trim().isNotEmpty == true ? null : '手机号不能为空';
                            }),
                          _phoneController.text != '' ? Positioned(
                            right: 0,
                            top: ScreenUtil().setWidth(16),
                            child: IconButton(
                              icon: Style.svg('assets/svgs/icon-guanbi.svg'),
                              onPressed: () {
                                final LoginState _state = state.clone();
                                _state.username = '';
                                dispatch(LoginActionCreator.updateStateAction(_state));
                              },
                            )
                          ) : const SizedBox(width: 0, height: 0)
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          TextFormField(
                            controller: _passwordController,
                            obscureText: state.obscure,
                            decoration: InputDecoration(
                              labelText: '登录密码',
                              hintText: '您的登录密码',
                              icon: Icon(Icons.lock_outline),
                            ),
                            onFieldSubmitted: (String value) {
                              final LoginState _state = state.clone();
                              _state.username = _phoneController.text;
                              _state.password = _passwordController.text;
                              dispatch(LoginActionCreator.updateStateAction(_state));
                            },
                            validator: (String v) {
                              return v.trim().isNotEmpty == true ? null : '登录密码不能为空';
                            }),
                          state.password != null ? Positioned(
                            right: 0,
                            top: ScreenUtil().setWidth(16),
                            child: IconButton(
                              icon: state.obscure == true ? Style.svg('assets/svgs/icon-miwen.svg') : Style.svg('assets/svgs/icon-icon_yulan.svg'),
                              onPressed: () {
                                final LoginState _state = state.clone();
                                _state.obscure = !state.obscure;
                                _state.password = _passwordController.text;
                                dispatch(LoginActionCreator.updateStateAction(_state));
                              },
                              )
                          ) : const Text('')
                        ],
                      ),
                      
                      Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                          alignment: Alignment.centerRight,
                          child: Text.rich(TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: '创建账户',
                                style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(26)),
                                recognizer: _tapGestureRecognizerOfCreateAccount..onTap = () {
                                  Navigator.of(viewService.context).pushNamed('register', arguments: <String, dynamic>{'param': <String, dynamic>{'test': 'test'}});
                                }),
                            const TextSpan(
                              text: '  '
                            ),
                            TextSpan(
                                text: '忘记密码',
                                style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(26)),
                                recognizer: _tapGestureRecognizer..onTap = () {
                                  Navigator.of(viewService.context).pushNamed('reset_password', arguments: <String, dynamic>{'param': <String, dynamic>{'test': 'test'}});
                                }),
                          ]))),
                      SizedBox(
                        height: ScreenUtil().setWidth(40)
                      ),
                      Container(
                          width: ScreenUtil().setWidth(width),
                          // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                          child: Builder(builder: (dynamic context) {
                            return RaisedButton(
                                child: Text(
                                  '登录',
                                  style: Style.buttonTextStyle
                                ),
                                onPressed: () {
                                  if((_formKey.currentState as FormState).validate()){
                                    dispatch(LoginActionCreator.onSubmitAction(<String, dynamic>{
                                      'username': _phoneController.text, 
                                      'password': _passwordController.text,
                                    }));
                                  }
                                });
                          })),
                      SizedBox(
                        height: ScreenUtil().setWidth(200)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(((width - 120)*1~/3).toInt()),
                            child: Divider(
                              height: Adapt.onepx(),
                            ),
                          ),
                          Text(
                            '其他登录方式',
                            style: TextStyle(
                              color: Colors.black54,
                              letterSpacing: 2
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(((width- 120)*1~/3).toInt()),
                            child: Divider(
                              height: Adapt.onepx(),
                            ),
                          )
                        ],
                      ),
                      Container(
                          // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(40)),
                          width: ScreenUtil().setWidth(width),
                          height: ScreenUtil().setWidth(80),
                          child: Builder(builder: (dynamic context) {
                            return OutlineButton(
                                /* icon: SvgPicture.asset(
                                  'assets/svgs/mode_comment-24px.svg',
                                  width: 24,
                                  height: 24,
                                ), */
                                highlightedBorderColor: Style.weichatColor,
                                highlightColor: Style.weichatColor.withOpacity(0.1),
                                splashColor: Style.weichatColor.withOpacity(0.7),
                                color: Style.weichatColor,
                                borderSide: BorderSide(color: Style.weichatColor.withOpacity(0.7)),
                                child: Text(
                                  '微信登录',
                                  style: TextStyle(
                                      color: Style.weichatColor.withOpacity(0.7),
                                      letterSpacing: 4
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: () {});
                          })),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ]
      ),
      );
}
