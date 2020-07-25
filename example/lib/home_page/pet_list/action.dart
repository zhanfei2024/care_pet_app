import 'package:fish_redux/fish_redux.dart';

enum PetListAction {onAdd }

class PetListActionCreator {
  static Action onAddAction() {
    return const Action(PetListAction.onAdd);
  }
}
