import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/device_page/todo_component/component.dart' as device;
import 'package:sample/home_page/action.dart';
import 'package:sample/home_page/fence_list/todo_component/component.dart';

import 'package:sample/state_model/Res.dart';
import 'package:sample/state_model/picker.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/HttpUtils.dart';

import 'action.dart';
import 'state.dart';

Effect<FenceSupplyState> buildEffect() {
  return combineEffects(<Object, Effect<FenceSupplyState>>{
    // ToDoEditAction.onDone: _onDone,
    Lifecycle.initState: _initState,
    ToDoEditAction.onChoiceDevice: _onChoiceDevice,
    ToDoEditAction.onSubmit:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<FenceSupplyState>>(_onSubmit),
  });
}

void _initState(Action action, Context<FenceSupplyState> ctx) async{
  final FenceSupplyState newState = ctx.state.clone();
  final FenceSupplyState deviceState = await devices(newState, ctx);
  ctx.dispatch(ToDoEditActionCreator.updateStateAction(deviceState));
}

// 新增围栏
Future<bool> addFence(Context<FenceSupplyState> ctx, Map<String, dynamic> _data) async {
  bool success;
  final ToastCustom toastCustom = ToastCustom();
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/fences', data: _data, method: HttpUtils.POST)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        toastCustom.showCustomWidgetToast(msg: '新增围栏成功');
        success = true;
      } else {
        toastCustom.showCustomWidgetToast(msg: '新增围栏失败，请重试');
      }
    }).catchError((dynamic e) {
    });
  return success;
}

Future<FenceSupplyState> devices(FenceSupplyState state, Context<FenceSupplyState> ctx) async {
  final ToastCustom toastCustom = ToastCustom();
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/devices', method: HttpUtils.GET)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final dynamic data = res.data;
        if(data != null && data['total'] > 0) {
          final List<dynamic> lists = data['lists'];
          final List<device.ToDoState> _lists = lists.map((dynamic i) {
            return device.ToDoState.fromJson(i);
          }).toList();
          int _index = -1;
          state.pickerState = _lists.map<PickerState>((device.ToDoState i) {
            _index = _index + 1;
            return PickerState()
              ..index = _index
              ..name = i.device_name
              ..value = i.id
              ..selected = false;
          }).toList();
          state.pickerState.first.selected = true;
          print(state.pickerState);
        }
      }
    }).catchError((dynamic e) {
      toastCustom.showCustomWidgetToast(msg: '出差了');
    });
  return state;
}

void _onSubmit(Action action, Context<FenceSupplyState> ctx) async{
  final ToastCustom toast = ToastCustom();
  final HttpUtils http = HttpUtils(context: ctx.context);
  final FenceSupplyState state = ctx.state.clone();
  if(state.isAddFence == true) {
    await http.request(url: '/api/v1/fences', data: action.payload, method: HttpUtils.POST)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          toast.showCustomWidgetToast(msg: '新增围栏成功');
          final ToDoState todo = ctx.state.clone().toDo;
          ctx.dispatch(HomeActionCreator.addFenceAction(todo));
          Navigator.of(ctx.context).popAndPushNamed('home', arguments: <String, dynamic>{'componentName': 'fence_list'});
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '新增出错了，请重试');
    });
  } else {
    await http.request(url: '/api/v1/fences/${state.toDo.id}', data: action.payload, method: HttpUtils.PUT)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          toast.showCustomWidgetToast(msg: '编辑围栏成功');
          final ToDoState todo = ctx.state.clone().toDo;
          ctx.dispatch(HomeActionCreator.onEditFenceAction(todo));
          Navigator.of(ctx.context).popAndPushNamed('home', arguments: <String, dynamic>{'componentName': 'fence_list'});
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '编辑出错了，请重试');
    });
  }
}

/// 绑定设备
void _onChoiceDevice(Action action, Context<FenceSupplyState> ctx) {
  final FenceSupplyState updateState = ctx.state.clone();
  final ToastCustom toast = ToastCustom();
  if (updateState.pickerState == null || updateState.pickerState?.isEmpty == true) {
    toast.showCustomWidgetToast(msg: '暂无设备，请添加设备后再绑定');
    Navigator.of(ctx.context).pushNamed('device');
    return;
  }
  void showPickerModal(BuildContext context) {
    Picker(
      columnPadding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
      cancelTextStyle: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.blue),
      selectedTextStyle: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colors.blue),
      adapter: PickerDataAdapter<String>(
        pickerdata: updateState.pickerState.map<String>((PickerState e) => e.name).toList()
      ),
      changeToFirst: true,
      selecteds: <int>[updateState.pickerState.singleWhere((PickerState e) => e.selected).index],
      hideHeader: false,
      confirmText: '确定',
      cancelText: '取消',
      onCancel: () {
        println('cancel');
      },
      onConfirm: (Picker picker, List<int> value) async{
        for (PickerState item in updateState.pickerState) {
          if(item.index == value[0]) {
            item.selected = true;
            updateState.toDo.device_id = item.value;
            updateState.deviceEditController = TextEditingController(text: item.name);
          } else {
            item.selected = false;
          }
        }
        ctx.dispatch(ToDoEditActionCreator.updateStateAction(updateState));
      }
    ).showModal<dynamic>(context);
  }
  showPickerModal(ctx.context);
}