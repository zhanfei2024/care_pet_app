import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Effect<LoadingState> buildEffect() {
  return combineEffects(<Object, Effect<LoadingState>>{
    LoadingAction.onToDetail: _onToDetail,
  });
}

void _onToDetail(Action action, Context<LoadingState> ctx) {
  Navigator.of(ctx.context).pushNamed('recharge');
}