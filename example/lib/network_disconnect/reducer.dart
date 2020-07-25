import 'package:fish_redux/fish_redux.dart';
import './state.dart';
import 'action.dart';

Reducer<NetWorkDisconnectState> buildReducer() {
  return asReducer(<Object, Reducer<NetWorkDisconnectState>>{
    NetWorkDisconnectAction.update: _update,
  });
}

NetWorkDisconnectState _update(NetWorkDisconnectState state, Action action) {
  NetWorkDisconnectState newState = state.clone();
  final NetWorkDisconnectState updateState = action.payload;
  newState = updateState;
  return newState;
}