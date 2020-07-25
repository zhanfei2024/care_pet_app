import 'package:fish_redux/fish_redux.dart';

import '../state.dart';


Reducer<PetListState> buildReducer() {
  return asReducer(<Object, Reducer<PetListState>>{
    // ToDoListAction.add: _add,
    // todo_action.ToDoAction.remove: _remove
  });
}

/* PetListState _add(PetListState state, Action action) {
  final ToDoState toDo = action.payload;
  return state.clone()..toDos = (state.toDos.toList()..add(toDo));
} */

/* PetListState _remove(PetListState state, Action action) {
  final int id = action.payload;
  return state.clone()
    ..toDos = (state.toDos.toList()
      ..removeWhere((ToDoState state) => state.id == id));
} */
