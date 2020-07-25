import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer<LoginState>(<Object, Reducer<LoginState>> {
    LoginAction.updateState: _update,
  });
}
LoginState _update(LoginState state, Action action) {
  LoginState newState = state.clone();
  final LoginState updateState = action.payload;
  newState = updateState;
  return newState;
}
