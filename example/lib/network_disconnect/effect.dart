
import 'package:fish_redux/fish_redux.dart';
import './state.dart';

Effect<NetWorkDisconnectState> buildEffect() {
  return combineEffects(<Object, Effect<NetWorkDisconnectState>> {
    Lifecycle.initState: _initState,
  });
}

dynamic _initState(Action action, Context<NetWorkDisconnectState> ctx) async{
}