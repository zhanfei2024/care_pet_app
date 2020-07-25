import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ToDoState> buildReducer() {
  return asReducer(<Object, Reducer<ToDoState>>{
    ToDoAction.edit: _edit,
    // ToDoAction.done: _markDone
  });
}

ToDoState _edit(ToDoState state, Action action) {
  final ToDoState toDo = action.payload;
  if (state.id == toDo.id) {
    return state.clone()
      ..pet_avatar = toDo.pet_avatar
      ..pet_name = toDo.pet_name
      ..pet_gender = toDo.pet_gender
      ..pet_age = toDo.pet_age
      ..pet_step = toDo.pet_step
      ..pet_status = toDo.pet_status;
  }
  return state;
}

/* ToDoState _markDone(ToDoState state, Action action) {
  final String uniqueId = action.payload;
  if (state.uniqueId == uniqueId) {
    return state.clone()..isDone = !state.isDone;
  }
  return state;
} */
