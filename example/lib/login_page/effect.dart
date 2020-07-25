import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/state_model/Res.dart';
import 'package:sample/state_model/auth.dart';



import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/HttpUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginAction.onTab: _onTab,
    LoginAction.onDone: _onDone,
    LoginAction.onChangeTheme: _onChangeTheme,
    LoginAction.onToDetail: _onToDetail,
    LoginAction.onSubmit: _onSubmit,
  });
}

void _onSubmit(Action action, Context<LoginState> ctx) async{
  final ToastCustom toastCustom = ToastCustom();
  toastCustom.showCustomWidgetToast(msg: '登录中...', duration: const Duration(seconds: 60));
  final HttpUtils http = HttpUtils(context: ctx.context);
  final ResState res = await http.request(url: '/auth', param: action.payload, method: HttpUtils.GET);
  if (res != null && res.code == 200 && res.msg == 'ok') {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String token = res.data['token'];
    final int userId = res.data['auth']['id'];
    prefs.setString('token', token);
    prefs.setInt('userId', userId);
    GlobalStore.store.dispatch(GlobalActionCreator.onsaveToken(token));

    await getAuthByID(ctx, userId);

    toastCustom.showCustomWidgetToast(msg: '登录成功');

    Navigator.of(ctx.context).pushNamed('home');
  }
}

Future<void> getAuthByID(Context<LoginState> ctx, int id) async {
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/auth/$id', method: HttpUtils.GET)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final dynamic data = res.data;
        if(data != null) {
          final AuthState auth = AuthState.fromJson(data);
          GlobalStore.store.dispatch(GlobalActionCreator.onsaveAuth(auth));
        }
      }
    }).catchError((dynamic e) {
    });
}


void _onToDetail(Action action, Context<LoginState> ctx) {
  Navigator.of(ctx.context).pushNamed(action.payload['url'], arguments: action.payload['param']);
}

void _onTab(Action action, Context<LoginState> ctx) {
  final LoginState state = ctx.state.clone();
  // state.currentIndex = action.payload;
  ctx.dispatch(LoginActionCreator.updateStateAction(state));
}
void _onDone(Action action, Context<LoginState> ctx) {
 /*  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.descEditController.text
      ..title = ctx.state.nameEditController.text,
  ); */
}

void _onChangeTheme(Action action, Context<LoginState> ctx) {
 /*  */ GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}
