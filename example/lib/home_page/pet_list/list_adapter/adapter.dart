import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/pet_list/todo_component/component.dart';

import '../state.dart';
import 'reducer.dart';

class ToDoListAdapter extends SourceFlowAdapter<PetListState> {
  ToDoListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'toDo': ToDoComponent(),
          },
          reducer: buildReducer(),
        );
}
