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
      ..fence_name = toDo.fence_name
      ..fence_desc = toDo.fence_desc
      ..fence_status = toDo.fence_status
      ..fence_positions = toDo.fence_positions
      ..device_id = toDo.device_id
      ..mapStyle = toDo.mapStyle
      ..accuracy = toDo.accuracy
      ..linePoints = toDo.linePoints;
  }
  return state;
}

ToDoState _markDone(ToDoState state, Action action) {
  final ToDoState toDoState = state;
  final int uniqueId = action.payload;
  if (state.id == uniqueId) {
    if (toDoState.fence_status == 0) {
      return state.clone()..fence_status = 1;
    } else if (toDoState.fence_status == 1) {
      return state.clone()..fence_status = 0;
    }
  }
  return state;
}
