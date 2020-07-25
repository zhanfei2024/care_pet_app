import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/pet_list/todo_component/state.dart';
import 'package:sample/home_page/fence_list/todo_component/state.dart' as fence;
import 'package:sample/home_page/state.dart';

enum HomeAction { onDone, onChangeTheme, onswitchComponent, updateState, addFence, onEditFence, addPet, onRefreshFence, onRefreshPet}

class HomeActionCreator {
  static Action onDone() {
    return const Action(HomeAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(HomeAction.onChangeTheme);
  }

  static Action onSwitchComponentAction(String v) {
    return Action(
      HomeAction.onswitchComponent,
      payload: v
    );
  }

  static Action updateStateAction(HomeState state) {
    return Action(
      HomeAction.updateState,
      payload: state
    );
  }
  static Action addFenceAction(fence.ToDoState state) {
    return Action(
      HomeAction.addFence,
      payload: state
    );
  }
  static Action onEditFenceAction(fence.ToDoState state) {
    return Action(
      HomeAction.onEditFence,
      payload: state
    );
  }
  static Action addPetAction(ToDoState state) {
    return Action(
      HomeAction.addPet,
      payload: state
    );
  }
  static Action onRefreshFenceAction() {
    return const Action(
      HomeAction.onRefreshFence,
    );
  }
  static Action onRefreshPetAction() {
    return const Action(
      HomeAction.onRefreshPet,
    );
  }

}
