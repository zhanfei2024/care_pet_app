import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<ModifyPhoneState> buildReducer() {
  return asReducer<ModifyPhoneState>(<Object, Reducer<ModifyPhoneState>> {
    ModifyPhoneAction.updateState: _update,
  });
}
ModifyPhoneState _update(ModifyPhoneState state, Action action) {
  ModifyPhoneState newState = state.clone();
  final ModifyPhoneState updateState = action.payload;
  newState = updateState;
  return newState;
}
