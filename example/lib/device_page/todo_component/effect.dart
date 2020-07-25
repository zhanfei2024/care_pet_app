import 'dart:async';
import 'package:sample/common/Format.dart';

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
    ToDoAction.onContact: _onContact,
  });
}

void _onEdit(Action action, Context<ToDoState> ctx) {
  if (action.payload == ctx.state.id) {
    Navigator.of(ctx.context)
        .pushNamed('device_edit', arguments: ctx.state)
        .then((dynamic toDo) {
      if (toDo != null) {
        ctx.dispatch(ToDoActionCreator.editAction(toDo));
      }
    });
  }
}

/// 删除设备
Future<bool> deleteDevice(Context<ToDoState> ctx) async {
  final ToastCustom toast = ToastCustom();
  bool isSuccess;
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/devices/${ctx.state.id}', method: HttpUtils.DELETE)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        isSuccess = true;
      } else {
        toast.showCustomWidgetToast(msg: '删除设备失败，请重试');
      }
    }).catchError((dynamic e) {
    });
  return isSuccess;
}

void _onContact(Action action, Context<ToDoState> ctx) async {
  int status = ctx.state.device_status;
  if(status == 0) {
    status = 1;
  } else if (status == 1) {
    status = 0;
  }
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        
        return AlertDialog(
          title: Text('你确定要${Format.deviceStatus(status)}设备?'),
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
    final ToDoState state = ctx.state.clone();
    state.device_status = status;
    final Map<String, dynamic> data = <String, dynamic>{
      'auth_id': state.auth_id,
      'pet_id': state.pet_id,
      'device_name': state.device_name,
      'device_imei': state.device_imei,
      'device_iccid': state.device_iccid,
      'device_status': state.device_status
    };
    final bool isSuccess = await editDevice(ctx, ctx.state.id, data);
    if (isSuccess == true) {
      ctx.dispatch(ToDoActionCreator.editAction(state));
    }
  }
}

Future<bool> editDevice(Context<ToDoState> ctx, int id,  Map<String, dynamic> data) async{
  final ToastCustom toast = ToastCustom();
  bool isSuccess;
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/devices/$id', data: data, method: HttpUtils.PUT)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        isSuccess = true;
        toast.showCustomWidgetToast(msg: '${Format.deviceStatus(data['device_status'])}设备成功');
      }
    }).catchError((dynamic e) {
      toast.showCustomWidgetToast(msg: '${Format.deviceStatus(data['device_status'])}设备出错了，请重试');
    });
  return isSuccess;
}



void _onRemove(Action action, Context<ToDoState> ctx) async {
  final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('你确定要删除设备"${ctx.state.device_imei}"?'),
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
    final bool isSuccess = await deleteDevice(ctx);
    if (isSuccess == true) {
      ctx.dispatch(ToDoActionCreator.removeAction(ctx.state.id));
    }
  }
}
