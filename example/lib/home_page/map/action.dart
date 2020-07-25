import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'state.dart';

enum MapAction { onEdit, edit, done, onRemove, remove, addPin, switchMapStyle, onMapMove }

class MapActionCreator {
  static Action onEditAction(String uniqueId) {
    return Action(MapAction.onEdit, payload: uniqueId);
  }

  static Action editAction(MapState toDo) {
    return Action(MapAction.edit, payload: toDo);
  }

  static Action doneAction(String uniqueId) {
    return Action(MapAction.done, payload: uniqueId);
  }

  static Action onRemoveAction(String uniqueId) {
    return Action(MapAction.onRemove, payload: uniqueId);
  }

  static Action removeAction(String uniqueId) {
    return Action(MapAction.remove, payload: uniqueId);
  }

  static Action addPinAction(LatLng v) {
    return Action(
      MapAction.addPin, 
      payload: v
    );
  }
  static Action switchMapStyleAction(int v) {
    return Action(
      MapAction.switchMapStyle, 
      payload: v
    );
  }
  static Action onMapMoveAction() {
    return const Action(
      MapAction.onMapMove, 
    );
  }
}
