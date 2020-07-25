import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

enum ToDoAction { onEdit, edit, done, onContact, onRemove, remove }

class ToDoActionCreator {
  static Action onEditAction(int id) {
    return Action(ToDoAction.onEdit, payload: id);
  }

  static Action editAction(ToDoState toDo) {
    return Action(ToDoAction.edit, payload: toDo);
  }

  static Action doneAction(int id) {
    return Action(ToDoAction.done, payload: id);
  }

  static Action onContactAction() {
    return const Action(ToDoAction.onContact);
  }

  static Action onRemoveAction(int id) {
    return Action(ToDoAction.onRemove, payload: id);
  }

  static Action removeAction(int uniqueId) {
    return Action(ToDoAction.remove, payload: uniqueId);
  }
}
