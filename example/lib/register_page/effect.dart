import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/toast/toastCustom.dart';
import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<RegisterState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterState>>{
    RegisterAction.onTab: _onTab,
    RegisterAction.onDone: _onDone,
    RegisterAction.onChangeTheme: _onChangeTheme,
    RegisterAction.onToDetail: _onToDetail,
    RegisterAction.onSubmit: _onSubmit
  });
}

final ToastCustom toastCustom = ToastCustom();

void _onSubmit(Action action, Context<RegisterState> ctx) async{
  /* final HttpUtils http = HttpUtils(context: ctx.context);
  final Map<String, dynamic> res = await http.request('/register', data: action.payload, method: HttpUtils.POST);
  if (res['code'] == 200) {
    Navigator.of(ctx.context).pushNamed('login');
  } */
}


void _onToDetail(Action action, Context<RegisterState> ctx) {
  Navigator.of(ctx.context).pushNamed(action.payload['url'], arguments: action.payload['param']);
}

void _onTab(Action action, Context<RegisterState> ctx) {
  // state.currentIndex = action.payload;
  // ctx.dispatch(RegisterActionCreator.updateStateAction(state));
}

void _onDone(Action action, Context<RegisterState> ctx) {
 /*  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.descEditController.text
      ..title = ctx.state.nameEditController.text,
  ); */
}

void _onChangeTheme(Action action, Context<RegisterState> ctx) {
 /*  */ GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}
