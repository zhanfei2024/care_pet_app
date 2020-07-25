import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/fence_list/todo_component/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FenceEditPage extends Page<FenceEditState, ToDoState> {
  FenceEditPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer()
          /* dependencies: Dependencies<FenceEditState>(
              adapter: NoneConn<HomeState>() + ToDoListAdapter(),
              slots: <String, Dependent<FenceEditState>>{
                'map': MapConnector() + MapComponent(),
              }), */

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<FenceEditState>>[
          //   logMiddleware(tag: 'FenceEditPage'),
          // ],
        );
}
