import 'dart:async';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/state_model/Res.dart';
import 'package:sample/utils/HttpUtils.dart';
import 'action.dart';
import 'list_adapter/action.dart' as list_action;
import 'state.dart';
import 'todo_component/state.dart';

Effect<DeviceState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceState>>{
    Lifecycle.initState: _init,
    PageAction.onAdd: _onAdd,
    PageAction.onRefreshDevice: _onRefreshDevice,
    PageAction.onLoadMore: _onLoadMore,
    PageAction.onShowLastEnd: _onShowLastEnd,
  });
}

void _init(Action action, Context<DeviceState> ctx) async{
  final DeviceState state = ctx.state.clone();
  final DeviceState newState = await devices(state, ctx);
  ctx.dispatch(PageActionCreator.updataStateAction(newState));
}

void _onAdd(Action action, Context<DeviceState> ctx) {
  Navigator.of(ctx.context)
      .pushNamed('device_edit', arguments: null)
      .then((dynamic toDo) {
    if (toDo != null &&
        (toDo.device_name?.isNotEmpty == true)) {
      ctx.dispatch(list_action.ToDoListActionCreator.add(toDo));
    }
  });
}
void _onRefreshDevice(Action action, Context<DeviceState> ctx) async{
  final DeviceState state = ctx.state.clone();
  state.isDevicesLoading = true;
  state.isDevicesEmpty = true;
  final DeviceState newState = await devices(state, ctx);
  ctx.dispatch(PageActionCreator.updataStateAction(newState)); 
}
void _onLoadMore(Action action, Context<DeviceState> ctx) async{
  final DeviceState state = ctx.state.clone();
  state.showMoreLoading = true;
  ctx.dispatch(PageActionCreator.updataStateAction(state)); 

  final DeviceState _state = ctx.state.clone();
  _state.devicesPageNum += 1;
  _state.maxScrollExtent = action.payload + 300;
  final DeviceState newState = await devices(_state, ctx);
  newState.showMoreLoading = false;
  ctx.dispatch(PageActionCreator.updataStateAction(newState)); 
}
void _onShowLastEnd(Action action, Context<DeviceState> ctx) async{
  final DeviceState state = ctx.state.clone();
  state.showLastEnd = true;
  ctx.dispatch(PageActionCreator.updataStateAction(state)); 
  Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    final DeviceState _state = ctx.state.clone();
    _state.showLastEnd = false;
    ctx.dispatch(PageActionCreator.updataStateAction(_state)); 
    timer.cancel();
    timer = null;
  });
}

Future<DeviceState> devices(DeviceState state, Context<DeviceState> ctx) async {
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/devices', param: <String, dynamic>
  {
    'page_num': state.devicesPageNum,
    'auth_id': state.userState.auth.id
  }, method: HttpUtils.GET)
    .then((ResState res) {
      state.isDevicesLoading = false;
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final Map<String, dynamic> data = res.data;
        if(data.containsKey('total') && data['total'] > 0) {
          final int total = data['total'];
          if(state.devicesPageNum * state.devicesPageLimit >= total) {
            state.isLastPageNum = true;
          }
          state.isDevicesEmpty = false;
          final List<dynamic> lists = data['lists'];
          final List<ToDoState> _lists = lists.map((dynamic i) {
            final ToDoState toDoState = ToDoState.fromJson(i);
            toDoState.pet_name = i['pet']['pet_name'];
            return toDoState;
          }).toList();
          state.toDos.addAll(_lists);
        }
      }
    }).catchError((dynamic e) {
      state.msg = e.toString();
    });
  return state;
}

