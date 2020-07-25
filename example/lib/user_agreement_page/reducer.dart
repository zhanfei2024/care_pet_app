import 'package:fish_redux/fish_redux.dart';
import './state.dart';
import 'action.dart';

Reducer<UserAgreeMentState> buildReducer() {
  return asReducer(<Object, Reducer<UserAgreeMentState>>{
    UserAgreeMentAction.update: _update,
  });
}

UserAgreeMentState _update(UserAgreeMentState state, Action action) {
  UserAgreeMentState newState = state.clone();
  final UserAgreeMentState updateState = action.payload;
  newState = updateState;
  return newState;
}