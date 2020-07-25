import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/state_model/user.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
      GlobalAction.changeFlutterMap: _changeFlutterMap,
      GlobalAction.saveToken: _saveToken,
      GlobalAction.saveAuth: _saveAuth,
      GlobalAction.changeCurrentLocation: _changeCurrentLocation,
    },
  );
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  final Color next =
      _colors[((_colors.indexOf(state.themeColor) + 1) % _colors.length)];
  return state.clone()..themeColor = next;
}
GlobalState _changeFlutterMap(GlobalState state, Action action) {
  return state.clone()..flutterMapState = action.payload;
}
GlobalState _saveToken(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  newState.userState ??= UserState();
  newState.userState.token = action.payload;
  return newState;
}
GlobalState _saveAuth(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  newState.userState ??= UserState();
  newState.userState.auth = action.payload;
  return newState;
}
GlobalState _changeCurrentLocation(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  newState.currentLocation = action.payload;
  return newState;
}