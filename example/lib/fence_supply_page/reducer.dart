import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<FenceSupplyState> buildReducer() {
  return asReducer(
    <Object, Reducer<FenceSupplyState>>{
      ToDoEditAction.updateState: _updateStateReducer,
    },
  );
}

FenceSupplyState _updateStateReducer(FenceSupplyState state, Action action) {
  final FenceSupplyState updateState = action.payload;
  FenceSupplyState newState = state.clone();
  newState = updateState;
  return newState;
}
