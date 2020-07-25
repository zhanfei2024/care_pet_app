import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

enum MeAction { onEdit, edit, done, onRemove, remove }

class MeActionCreator {
  static Action onEditAction(String uniqueId) {
    return Action(MeAction.onEdit, payload: uniqueId);
  }

  static Action editAction(ProfileState toDo) {
    return Action(MeAction.edit, payload: toDo);
  }

  static Action doneAction(String uniqueId) {
    return Action(MeAction.done, payload: uniqueId);
  }

  static Action onRemoveAction(String uniqueId) {
    return Action(MeAction.onRemove, payload: uniqueId);
  }

  static Action removeAction(String uniqueId) {
    return Action(MeAction.remove, payload: uniqueId);
  }
}
