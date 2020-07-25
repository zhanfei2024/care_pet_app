import 'package:fish_redux/fish_redux.dart';

import '../state.dart';

// import '../todo_component/action.dart' as todo_action;
// import '../todo_component/component.dart';

Reducer<FenceListState> buildReducer() {
  return asReducer(<Object, Reducer<FenceListState>>{
    
  });
}

/* FenceListState _add(FenceListState state, Action action) {
  final ToDoState toDo = action.payload;
  return state.clone()..toDos = (state.toDos.toList()..add(toDo));
}

FenceListState _remove(FenceListState state, Action action) {
  final int id = action.payload;
  return state.clone()
    ..toDos = (state.toDos.toList()
      ..removeWhere((ToDoState state) => state.id == id));
} */
