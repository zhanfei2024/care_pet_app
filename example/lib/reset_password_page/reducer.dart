import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<ResetPasswordState> buildReducer() {
  return asReducer<ResetPasswordState>(<Object, Reducer<ResetPasswordState>> {
    ResetPasswordAction.updateState: _update,
  });
}
ResetPasswordState _update(ResetPasswordState state, Action action) {
  ResetPasswordState newState = state.clone();
  final ResetPasswordState updateState = action.payload;
  newState = updateState;
  return newState;
}
