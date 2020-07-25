import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/fence_edit_page/state.dart';

enum ToDoEditAction { onDone, updateState, onChangeTheme, addPin, switchMapStyle, moveMarker, saveStartDrag, removeMarker, onRemoveMarker, onChoiceDevice  }

class ToDoEditActionCreator {
  static Action onDone() {
    return const Action(ToDoEditAction.onDone);
  }

  static Action updateStateAction(FenceEditState v) {
    return Action(
      ToDoEditAction.updateState,
      payload: v
    );
  }

  static Action onChangeTheme() {
    return const Action(ToDoEditAction.onChangeTheme);
  }

  static Action addPinAction(LatLng v) {
    return Action(
      ToDoEditAction.addPin, 
      payload: v
    );
  }
  static Action switchMapStyleAction(int v) {
    return Action(
      ToDoEditAction.switchMapStyle, 
      payload: v
    );
  }
  static Action moveMarkerAction(Map<String, dynamic> v) {
    return Action(
      ToDoEditAction.moveMarker, 
      payload: v
    );
  }
  static Action saveStartDragAction(LatLng v) {
    return Action(
      ToDoEditAction.saveStartDrag, 
      payload: v
    );
  }
  static Action removeMarkerAction(LatLng v) {
    return Action(
      ToDoEditAction.removeMarker, 
      payload: v
    );
  }
  static Action onRemoveMarkerAction(LatLng v) {
    return Action(
      ToDoEditAction.onRemoveMarker, 
      payload: v
    );
  }
  static Action onChoiceDeviceAction() {
    return const Action(
      ToDoEditAction.onChoiceDevice, 
    );
  }
}
