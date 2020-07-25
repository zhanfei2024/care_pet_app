import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<FenceEditState> buildEffect() {
  return combineEffects(<Object, Effect<FenceEditState>>{
    // Lifecycle.initState: _initState,
    ToDoEditAction.onDone: _onDone,
    ToDoEditAction.onChangeTheme: _onChangeTheme,
    ToDoEditAction.onRemoveMarker: _onRemoveMarker,
  });
}

void _onDone(Action action, Context<FenceEditState> ctx) async{
  Navigator.of(ctx.context).pushNamed('fence_supply', arguments: ctx.state.toDo);
}

void _onChangeTheme(Action action, Context<FenceEditState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}

void _onRemoveMarker(Action action, Context<FenceEditState> ctx) async{
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text('确定要删除此经纬度点？'),
          actions: <Widget>[
            RaisedButton(
              color: Colors.grey,
              elevation: 2.0, //正常状态下的阴影
              highlightElevation: 8.0,//按下时的阴影
              disabledElevation: 0.0,// 禁用时的阴影
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: const Text('取消'),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.of(buildContext).pop();
              }
            ),
            RaisedButton(
              color: Colors.blue,
              elevation: 2.0, //正常状态下的阴影
              highlightElevation: 8.0,//按下时的阴影
              disabledElevation: 0.0,// 禁用时的阴影
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: const Text('取消'),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.of(buildContext).pop('Yes');
              }
            ),
          ],
        );
      });

  if (select == 'Yes') {
    ctx.dispatch(ToDoEditActionCreator.removeMarkerAction(action.payload));
  }
}
