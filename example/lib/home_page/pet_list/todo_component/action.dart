import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

enum ToDoAction { onEdit, edit, done, onRemove, remove }

class ToDoActionCreator {
  static Action onEditAction(int id) {
    return Action(ToDoAction.onEdit, payload: id);
  }

  static Action editAction(ToDoState toDo) {
    return Action(ToDoAction.edit, payload: toDo);
  }

  static Action doneAction(int uniqueId) {
    return Action(ToDoAction.done, payload: uniqueId);
  }

  static Action onRemoveAction(int uniqueId) {
    return Action(ToDoAction.onRemove, payload: uniqueId);
  }

  static Action removeAction(int uniqueId) {
    return Action(ToDoAction.remove, payload: uniqueId);
  }
}
