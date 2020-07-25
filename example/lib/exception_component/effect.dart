import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Effect<ExceptionState> buildEffect() {
  return combineEffects(<Object, Effect<ExceptionState>>{
    ExceptionAction.onToDetail: _onToDetail,
  });
}

void _onToDetail(Action action, Context<ExceptionState> ctx) {
  Navigator.of(ctx.context).pushNamed('recharge');
}