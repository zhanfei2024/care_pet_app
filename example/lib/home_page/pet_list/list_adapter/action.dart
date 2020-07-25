import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/pet_list/todo_component/state.dart';

enum ToDoListAction { add }

class ToDoListActionCreator {
  static Action add(ToDoState state) {
    return Action(ToDoListAction.add, payload: state);
  }
}
