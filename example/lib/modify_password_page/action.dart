import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum ModifyPasswordAction { updateState, onDone, onChangeTheme, onTab }

class ModifyPasswordActionCreator {
  static Action updateStateAction(ModifyPasswordState value) {
    return Action(
      ModifyPasswordAction.updateState,
      payload: value
    );
  }
  static Action onTabAction({int value}) {
    return  Action(
      ModifyPasswordAction.onTab,
      payload: value
    );
  }
  static Action onDone() {
    return const Action(ModifyPasswordAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(ModifyPasswordAction.onChangeTheme);
  }
}
