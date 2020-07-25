import 'package:fish_redux/fish_redux.dart';

enum FenceListAction {onAdd }

class FenceListActionCreator {
  static Action onAddAction() {
    return const Action(FenceListAction.onAdd);
  }
}
