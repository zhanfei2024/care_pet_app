import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/pet_list/todo_component/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PetEditPage extends Page<PetEditState, ToDoState> {
  PetEditPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer()
          /// 页面私有AOP，如果需要
          // middleware: <Middleware<PetEditState>>[
          //   logMiddleware(tag: 'PetEditPage'),
          // ],
        );
}
