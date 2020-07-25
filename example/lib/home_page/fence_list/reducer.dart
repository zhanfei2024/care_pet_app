import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<FenceListState> buildReducer() {
  return asReducer(
    <Object, Reducer<FenceListState>>{},
  );
}

/* FenceListState _initToDosReducer(FenceListState state, Action action) {
  final List<ToDoState> toDos = action.payload ?? <ToDoState>[];
  final FenceListState newState = state.clone();
  newState.toDos = toDos;
  return newState;
} */
