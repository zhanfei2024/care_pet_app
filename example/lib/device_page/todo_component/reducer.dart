import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ToDoState> buildReducer() {
  return asReducer(<Object, Reducer<ToDoState>>{
    ToDoAction.edit: _edit,
    ToDoAction.done: _markDone
  });
}

ToDoState _edit(ToDoState state, Action action) {
  final ToDoState toDo = action.payload;
  if (state.id == toDo.id) {
    return state.clone()
      ..device_name = toDo.device_name
      ..device_imei = toDo.device_imei
      ..device_iccid = toDo.device_iccid
      ..device_status = toDo.device_status;
  }
  return state;
}

ToDoState _markDone(ToDoState state, Action action) {
  final int id = action.payload;
  if (state.id == id) {
    return state.clone()..isDone = !state.isDone;
  }
  return state;
}
