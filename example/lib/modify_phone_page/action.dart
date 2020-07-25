import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum ModifyPhoneAction { updateState, onDone, onChangeTheme, onTab }

class ModifyPhoneActionCreator {
  static Action updateStateAction(ModifyPhoneState value) {
    return Action(
      ModifyPhoneAction.updateState,
      payload: value
    );
  }
  static Action onTabAction({int value}) {
    return  Action(
      ModifyPhoneAction.onTab,
      payload: value
    );
  }
  static Action onDone() {
    return const Action(ModifyPhoneAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(ModifyPhoneAction.onChangeTheme);
  }
}
