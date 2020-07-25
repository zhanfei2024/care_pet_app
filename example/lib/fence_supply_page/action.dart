import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum ToDoEditAction { onDone, onChangeTheme, onChoiceDevice, updateState, onScanImei, onSubmit }

class ToDoEditActionCreator {
  static Action onDone() {
    return const Action(ToDoEditAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(ToDoEditAction.onChangeTheme);
  }
  static Action onChoiceDeviceAction() {
    return const Action(ToDoEditAction.onChoiceDevice);
  }
  static Action updateStateAction(FenceSupplyState v) {
    return
     Action(
       ToDoEditAction.updateState,
       payload: v
     );
  }
  static Action onScanImeiAction() {
    return
    const Action(
       ToDoEditAction.onScanImei,
     );
  }
  static Action onSubmitAction(Map<String, dynamic> v) {
    return
    Action(
       ToDoEditAction.onSubmit,
       payload: v
     );
  }
}
