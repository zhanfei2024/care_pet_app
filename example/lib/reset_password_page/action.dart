import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum ResetPasswordAction { updateState, onDone, onChangeTheme, onTab, onToDetail }

class ResetPasswordActionCreator {
  static Action updateStateAction(ResetPasswordState value) {
    return Action(
      ResetPasswordAction.updateState,
      payload: value
    );
  }
  static Action onTabAction({int value}) {
    return  Action(
      ResetPasswordAction.onTab,
      payload: value
    );
  }
  static Action onDone() {
    return const Action(ResetPasswordAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(ResetPasswordAction.onChangeTheme);
  }
  static Action onToDetailAction(Map<String, dynamic> value) {
    return Action(ResetPasswordAction.onToDetail, payload: value);
  }
}
