import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum LoginAction { updateState, onDone, onChangeTheme, onTab, onToDetail, onSubmit }

class LoginActionCreator {
  static Action updateStateAction(LoginState value) {
    return Action(
      LoginAction.updateState,
      payload: value
    );
  }
  static Action onTabAction({int value}) {
    return  Action(
      LoginAction.onTab,
      payload: value
    );
  }
  static Action onSubmitAction(Map<String, dynamic> value) {
    return  Action(
      LoginAction.onSubmit,
      payload: value
    );
  }
  static Action onDone() {
    return const Action(LoginAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(LoginAction.onChangeTheme);
  }
  static Action onToDetailAction(Map<String, dynamic> value) {
    return Action(LoginAction.onToDetail, payload: value);
  }
}
