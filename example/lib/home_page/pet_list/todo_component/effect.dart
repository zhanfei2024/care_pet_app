import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/state_model/Res.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/HttpUtils.dart';

import 'action.dart';
import 'state.dart';

Effect<ToDoState> buildEffect() {
  return combineEffects(<Object, Effect<ToDoState>>{
    ToDoAction.onEdit: _onEdit,
    ToDoAction.onRemove: _onRemove,
  });
}

void _onEdit(Action action, Context<ToDoState> ctx) {
  if (action.payload == ctx.state.id) {
    Navigator.of(ctx.context)
        // .push<ToDoState>(MaterialPageRoute<ToDoState>(
        //     builder: (BuildContext buildCtx) =>
        //         edit_page.TodoEditPage().buildPage(ctx.state)))
        .pushNamed('pet_edit', arguments: ctx.state)
        .then((dynamic toDo) {
      if (toDo != null) {
        ctx.dispatch(ToDoActionCreator.editAction(toDo));
      }
    });
  }
}

/// 删除宠物
Future<bool> deleteFence(Context<ToDoState> ctx) async {
  final ToastCustom toast = ToastCustom();
  bool isSuccess;
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/pets/${ctx.state.id}', method: HttpUtils.DELETE)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        isSuccess = true;
      } else {
        toast.showCustomWidgetToast(msg: '删除失败，请重试');
      }
    }).catchError((dynamic e) {
    });
  return isSuccess;
}

void _onRemove(Action action, Context<ToDoState> ctx) async {
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('你确定要删除"${ctx.state.pet_name}"?'),
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
              child: const Text('确定'),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.of(buildContext).pop('Yes');
              }
            ),
          ],
        );
      });

  if (select == 'Yes') {
    final bool isSuccess = await deleteFence(ctx);
    if (isSuccess == true) {
      ctx.dispatch(ToDoActionCreator.removeAction(ctx.state.id));
    }
  }
}
