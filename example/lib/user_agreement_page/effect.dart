import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/toast/toastCustom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import './state.dart';
import 'action.dart';

Effect<UserAgreeMentState> buildEffect() {
  return combineEffects(<Object, Effect<UserAgreeMentState>> {
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    UserAgreeMentAction.onCallPhone: _onCallPhone,
    UserAgreeMentAction.onAgree: _onAgree,
    UserAgreeMentAction.onRefuse: _onRefuse
  });
}

dynamic _initState(Action action, Context<UserAgreeMentState> ctx) async{
  final UserAgreeMentState state = ctx.state.clone();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String agreement = prefs.getString('agreement');
  if(agreement == null) {
    Timer timer;
    state.timer =  Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
      final UserAgreeMentState state = ctx.state.clone();
      if(state.count == 0) {
        timer.cancel();
        timer = null;
      } else {
        state.count = state.count - 1;
        ctx.dispatch(UserAgreeMentActionCreator.updateAction(state));
      }
    });
  } else if(agreement == 'yes') {
    final UserAgreeMentState state = ctx.state.clone();
    state.agreement = 'yes';
    ctx.dispatch(UserAgreeMentActionCreator.updateAction(state));
  }
}

void _dispose(Action action, Context<UserAgreeMentState> ctx) {
  final UserAgreeMentState state = ctx.state.clone();
  if(state.timer != null) {
    state.timer.cancel();
    state.timer = null;
    ctx.dispatch(UserAgreeMentActionCreator.updateAction(state));
  }
}

void _onCallPhone(Action action, Context<UserAgreeMentState> ctx) {
  callPhone('tel:${action.payload}');
}
void _onAgree(Action action, Context<UserAgreeMentState> ctx) async{
  final ToastCustom toast = ToastCustom();
  toast.showCustomWidgetToast(msg: '欢迎使用车库电桩APP');
  final UserAgreeMentState state = ctx.state.clone();
  if(state.count > 0) {
    toast.showCustomWidgetToast(msg: '请阅读用户协议和隐私政策');
  } else {
    // 写入authorization到本地文件
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('agreement', 'yes');
    Navigator.of(ctx.context).pushNamed('home');
  }
}
void _onRefuse(Action action, Context<UserAgreeMentState> ctx) {
  final ToastCustom toast = ToastCustom();
  toast.showCustomWidgetToast(msg: '使用车库电桩APP，需要阅读并同意用户协议和隐私政策！', duration: const Duration(seconds: 2));
}
Future<void> callPhone(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
