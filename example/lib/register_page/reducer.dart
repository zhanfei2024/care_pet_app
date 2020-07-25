import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<RegisterState> buildReducer() {
  return asReducer<RegisterState>(<Object, Reducer<RegisterState>> {
    RegisterAction.updateState: _update,
  });
}
RegisterState _update(RegisterState state, Action action) {
  RegisterState newState = state.clone();
  final RegisterState updateState = action.payload;
  newState = updateState;
  return newState;
}
