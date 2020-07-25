import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

enum ToDoAction { onEdit, edit, done, onRemove, remove, onChangeFenceStatus }

class ToDoActionCreator {
  static Action onEditAction(int uniqueId) {
    return Action(ToDoAction.onEdit, payload: uniqueId);
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

  static Action onChangeFenceStatusAction() {
    return const Action(ToDoAction.onChangeFenceStatus);
  }
}
