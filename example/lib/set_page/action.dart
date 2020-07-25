import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

enum SetAction { onEdit, edit, done, onRemove, remove, onLogout }

class SetActionCreator {
  static Action onEditAction(String uniqueId) {
    return Action(SetAction.onEdit, payload: uniqueId);
  }

  static Action editAction(SetState toDo) {
    return Action(SetAction.edit, payload: toDo);
  }

  static Action doneAction(String uniqueId) {
    return Action(SetAction.done, payload: uniqueId);
  }

  static Action onRemoveAction(String uniqueId) {
    return Action(SetAction.onRemove, payload: uniqueId);
  }

  static Action removeAction(String uniqueId) {
    return Action(SetAction.remove, payload: uniqueId);
  }
  static Action onLogoutAction() {
    return const Action(SetAction.onLogout);
  }
}
