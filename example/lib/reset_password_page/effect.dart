import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<ResetPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ResetPasswordState>>{
    ResetPasswordAction.onTab: _onTab,
    ResetPasswordAction.onDone: _onDone,
    ResetPasswordAction.onChangeTheme: _onChangeTheme,
    ResetPasswordAction.onToDetail: _onToDetail,
  });
}


void _onToDetail(Action action, Context<ResetPasswordState> ctx) {
  Navigator.of(ctx.context).pushNamed(action.payload['url'], arguments: action.payload['param']);
}
void _onTab(Action action, Context<ResetPasswordState> ctx) {
  final ResetPasswordState state = ctx.state.clone();
  state.currentIndex = action.payload;
  ctx.dispatch(ResetPasswordActionCreator.updateStateAction(state));
}
void _onDone(Action action, Context<ResetPasswordState> ctx) {
 /*  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.descEditController.text
      ..title = ctx.state.nameEditController.text,
  ); */
}

void _onChangeTheme(Action action, Context<ResetPasswordState> ctx) {
 /*  */ GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}
