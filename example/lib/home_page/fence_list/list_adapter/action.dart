import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/fence_list/todo_component/state.dart';

enum ToDoListAction { add }

class ToDoListActionCreator {
  static Action add(ToDoState state) {
    return Action(ToDoListAction.add, payload: state);
  }
}
