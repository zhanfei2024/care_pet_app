import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'fence_list/component.dart';
import 'keepAlive.dart';
import 'map/component.dart';
import 'me/component.dart';
import 'pet_list/component.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>> {
  @override
  HomeStateKeepAliveStf createState() => HomeStateKeepAliveStf();
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
          dependencies: Dependencies<HomeState>(
              // adapter: NoneConn<HomeState>() + ToDoListAdapter(),
              slots: <String, Dependent<HomeState>>{
                'map': MapConnector() + MapComponent(),
                'fence_list': FenceListConnector() + FenceListComponent(),
                'pet_list': PetListConnector() + PetListComponent(),
                'me': MeConnector() + MeComponent()
              }),

          /// 页面私有AOP，如果需要
          // middleware: <Middleware<HomeState>>[
          //   logMiddleware(tag: 'HomePage'),
          // ],
        );
}
