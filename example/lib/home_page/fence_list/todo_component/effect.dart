import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/common/Format.dart';
import 'package:sample/state_model/Res.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/HttpUtils.dart';

import 'action.dart';
import 'state.dart';

Effect<ToDoState> buildEffect() {
  return combineEffects(<Object, Effect<ToDoState>>{
    ToDoAction.onEdit: _onEdit,
    ToDoAction.onRemove: _onRemove,
    ToDoAction.onChangeFenceStatus: _onChangeFenceStatus,
  });
}

void _onEdit(Action action, Context<ToDoState> ctx) {
  if (action.payload == ctx.state.id) {
    Navigator.of(ctx.context)
        // .push<ToDoState>(MaterialPageRoute<ToDoState>(
        //     builder: (BuildContext buildCtx) =>
        //         edit_page.TodoEditPage().buildPage(ctx.state)))
        .pushNamed('fence_edit', arguments: ctx.state)
        .then((dynamic toDo) {
      if (toDo != null) {
        ctx.dispatch(ToDoActionCreator.editAction(toDo));
      }
    });
  }
}

/// 删除围栏
Future<bool> deleteFence(Context<ToDoState> ctx) async {
  final ToastCustom toast = ToastCustom();
  bool isSuccess;
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/fences/${ctx.state.id}', method: HttpUtils.DELETE)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        isSuccess = true;
      } else {
        toast.showCustomWidgetToast(msg: '删除围栏失败，请重试');
      }
    }).catchError((dynamic e) {
    });
  return isSuccess;
}

void _onChangeFenceStatus(Action action, Context<ToDoState> ctx) async {
  final ToDoState state = ctx.state.clone();
  if(state.fence_status == 0) {
    state.fence_status = 1;
  } else if(state.fence_status == 1) {
    state.fence_status = 0;
  }
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('你确定要${Format.fenceStatus(state.fence_status)}围栏?'),
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
    final Map<String, dynamic> data = <String, dynamic>{
      'fence_name': state.fence_name,
      'fence_desc': state.fence_desc,
      'fence_status': state.fence_status,
      'fence_positions': state.fence_positions,
      'device_id': state.device_id
    };
    final ToastCustom toast = ToastCustom();
    final HttpUtils http = HttpUtils(context: ctx.context);
    await http.request(url: '/api/v1/fences/${ctx.state.id}', data: data, method: HttpUtils.PUT)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          ctx.dispatch(ToDoActionCreator.editAction(state));
          toast.showCustomWidgetToast(msg: '${Format.fenceStatus(state.fence_status)}围栏成功');
        } else {
          toast.showCustomWidgetToast(msg: '${Format.fenceStatus(state.fence_status)}围栏失败，请重试');
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '${Format.fenceStatus(state.fence_status)}围栏围栏出错了，请重试');
      });
  }
}

void _onRemove(Action action, Context<ToDoState> ctx) async {
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('你确定要删除围栏"${ctx.state.fence_name}"?'),
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
    if(isSuccess == true) {
      ctx.dispatch(ToDoActionCreator.removeAction(ctx.state.id));
    }
  }
}
