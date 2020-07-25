import 'package:fish_redux/fish_redux.dart';
import 'package:sample/exception_component/component.dart';
import 'package:sample/loading_component/component.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';

import 'view.dart';

class DevicePage extends Page<DeviceState, Map<String, dynamic>> {
  DevicePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DeviceState>(
              adapter: NoneConn<DeviceState>() + ToDoListAdapter(),
              slots: <String, Dependent<DeviceState>>{
                'loading': LoadingConnector() + LoadingComponent(),
                'exception': ExceptionConnector() + ExceptionComponent(),
              }),

          /// 页面私有AOP, 如果需要
          // middleware: <Middleware<PageState>>[
          //   logMiddleware(tag: 'ToDoListPage'),
          // ],
        );
}
