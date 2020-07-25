import 'package:fish_redux/fish_redux.dart';
import 'package:sample/device_page/todo_component/component.dart';

import '../state.dart';
import 'reducer.dart';

class ToDoListAdapter extends SourceFlowAdapter<DeviceState> {
  ToDoListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'toDo': ToDoComponent(),
          },
          reducer: buildReducer(),
        );
}
