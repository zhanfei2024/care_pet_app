import 'package:fish_redux/fish_redux.dart';
import 'package:sample/device_page/todo_component/component.dart';

import '../state.dart';

import '../todo_component/action.dart' as todo_action;
import '../todo_component/component.dart';
import 'action.dart';

Reducer<DeviceState> buildReducer() {
  return asReducer(<Object, Reducer<DeviceState>>{
    ToDoListAction.add: _add,
    todo_action.ToDoAction.remove: _remove
  });
}

DeviceState _add(DeviceState state, Action action) {
  final ToDoState toDo = action.payload;
  state.toDos ??= <ToDoState>[];
  final DeviceState newState = state.clone()..toDos = (state.toDos.toList()..add(toDo)).toList();
  if (newState.toDos.isNotEmpty) {
    newState.isDevicesEmpty = false;
  }
  return newState;
}

DeviceState _remove(DeviceState state, Action action) {
  final int unique = action.payload;
  final DeviceState newState = state.clone()
    ..toDos = (state.toDos.toList()
      ..removeWhere((ToDoState state) => state.id == unique));
  if(newState.toDos.isEmpty) {
    newState.isDevicesEmpty = true;
  }
  return newState;
}
