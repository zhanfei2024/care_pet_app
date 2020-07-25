import 'package:fish_redux/fish_redux.dart';
import 'package:sample/device_page/action.dart';

import 'state.dart';

Reducer<DeviceState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceState>>{PageAction.updataState: _updataReducer},
  );
}

DeviceState _updataReducer(DeviceState state, Action action) {
  DeviceState newState = state.clone();
  final  DeviceState updateState = action.payload;
  newState = updateState;
  return newState;
}
