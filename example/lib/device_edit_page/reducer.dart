import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<DeviceEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceEditState>>{
      ToDoEditAction.updateState: _updateStateReducer,
    },
  );
}

DeviceEditState _updateStateReducer(DeviceEditState state, Action action) {
  final DeviceEditState updateState = action.payload;
  DeviceEditState newState = state.clone();
  newState = updateState;
  return newState;
}
