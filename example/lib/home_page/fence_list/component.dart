import 'package:fish_redux/fish_redux.dart';
import 'package:sample/exception_component/component.dart';
import 'package:sample/loading_component/component.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';

import 'view.dart';

class FenceListComponent extends Component<FenceListState> {
  FenceListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FenceListState>(
              adapter: NoneConn<FenceListState>() + ToDoListAdapter(),
              slots: <String, Dependent<FenceListState>>{
                // 'report': ReportConnector() + ReportComponent(),
                'loading': LoadingConnector() + LoadingComponent(),
                'exception': ExceptionConnector() + ExceptionComponent(),
              }),

          /// 页面私有AOP, 如果需要
          // middleware: <Middleware<PageState>>[
          //   logMiddleware(tag: 'ToDoListPage'),
          // ],
        );
}
