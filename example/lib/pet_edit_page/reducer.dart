import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<PetEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<PetEditState>>{
      ToDoEditAction.updateState: _updateStateReducer,
    },
  );
}

PetEditState _updateStateReducer(PetEditState state, Action action) {
  final PetEditState updateState = action.payload;
  PetEditState newState = state.clone();
  newState = updateState;
  return newState;
}
