import 'package:fish_redux/fish_redux.dart';
import 'package:sample/device_edit_page/state.dart';

enum ToDoEditAction { onDone, onChangeTheme, onChoicePet, updateState, onScanImei, onSubmit }

class ToDoEditActionCreator {
  static Action onDone() {
    return const Action(ToDoEditAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(ToDoEditAction.onChangeTheme);
  }
  static Action onChoicePetAction() {
    return const Action(ToDoEditAction.onChoicePet);
  }
  static Action updateStateAction(DeviceEditState v) {
    return
     Action(
       ToDoEditAction.updateState,
       payload: v
     );
  }
  static Action onScanImeiAction() {
    return const Action(
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
