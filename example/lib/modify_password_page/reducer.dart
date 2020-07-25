import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<ModifyPasswordState> buildReducer() {
  return asReducer<ModifyPasswordState>(<Object, Reducer<ModifyPasswordState>> {
    ModifyPasswordAction.updateState: _update,
  });
}
ModifyPasswordState _update(ModifyPasswordState state, Action action) {
  ModifyPasswordState newState = state.clone();
  final ModifyPasswordState updateState = action.payload;
  newState = updateState;
  return newState;
}
