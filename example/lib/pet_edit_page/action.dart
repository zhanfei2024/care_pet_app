import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum ToDoEditAction { onDone, onChangeTheme, onUploadImage, updateState, onChoiceGender, onSubmit }

class ToDoEditActionCreator {
  static Action onDone() {
    return const Action(ToDoEditAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(ToDoEditAction.onChangeTheme);
  }
  static Action onUploadImageAction() {
    return const Action(ToDoEditAction.onUploadImage);
  }
  static Action updateState(PetEditState state) {
    return Action(
      ToDoEditAction.updateState,
      payload: state
    );
  }
  static Action onChoiceGenderAction(int v) {
    return Action(
      ToDoEditAction.onChoiceGender,
      payload: v
    );
  }
  static Action onSubmitAction(Map<String, dynamic> v) {
    return Action(
      ToDoEditAction.onSubmit,
      payload: v
    );
  }
}
