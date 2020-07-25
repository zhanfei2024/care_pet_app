import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/global_store/action.dart';
import 'package:sample/global_store/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'action.dart';
import 'state.dart';

Effect<SetState> buildEffect() {
  return combineEffects(<Object, Effect<SetState>>{
    SetAction.onLogout: _onLogout
  });
}

void _onLogout(Action action, Context<SetState> ctx) async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.remove('token');
  GlobalStore.store.dispatch(GlobalActionCreator.onsaveToken(null));
  Navigator.of(ctx.context).pushNamed('login');
}