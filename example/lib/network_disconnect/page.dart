import 'package:fish_redux/fish_redux.dart';
import './state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';

class NetWorkDisconnectPage extends Page<NetWorkDisconnectState, Map<String, dynamic>> {
    NetWorkDisconnectPage():
        super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
      );
        
}

