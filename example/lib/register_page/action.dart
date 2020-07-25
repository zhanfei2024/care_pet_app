import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum RegisterAction { updateState, onDone, onChangeTheme, onTab, onToDetail, onSubmit }

class RegisterActionCreator {
  static Action updateStateAction(RegisterState value) {
    return Action(
      RegisterAction.updateState,
      payload: value
    );
  }
  static Action onSubmitAction(Map<String, dynamic> value) {
    return Action(
      RegisterAction.onSubmit,
      payload: value
    );
  }
  static Action onTabAction({int value}) {
    return  Action(
      RegisterAction.onTab,
      payload: value
    );
  }
  static Action onDone() {
    return const Action(RegisterAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(RegisterAction.onChangeTheme);
  }
  static Action onToDetailAction(Map<String, dynamic> value) {
    return Action(RegisterAction.onToDetail, payload: value);
  }
}
