import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<PetListState> buildReducer() {
  return asReducer(
    <Object, Reducer<PetListState>>{},
  );
}

/* PetListState _initToDosReducer(PetListState state, Action action) {
  final List<ToDoState> toDos = action.payload ?? <ToDoState>[];
  final PetListState newState = state.clone();
  newState.toDos = toDos;
  return newState;
} */
