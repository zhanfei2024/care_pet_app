import 'package:fish_redux/fish_redux.dart';
import 'package:sample/device_page/todo_component/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DeviceEditPage extends Page<DeviceEditState, ToDoState> {
  DeviceEditPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          /// 页面私有AOP，如果需要
          // middleware: <Middleware<DeviceEditState>>[
          //   logMiddleware(tag: 'DeviceEditPage'),
          // ],
        );
}
