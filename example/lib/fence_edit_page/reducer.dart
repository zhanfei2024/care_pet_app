import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'action.dart';
import 'state.dart';

Reducer<FenceEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<FenceEditState>>{
      ToDoEditAction.updateState: _updateStateReducer,
      ToDoEditAction.moveMarker: _moveMarkerReducer,
      ToDoEditAction.saveStartDrag: _saveStartDragReducer,
      ToDoEditAction.addPin: _addPinReducer,
      ToDoEditAction.removeMarker: _removeMarkerReducer,
    },
  );
}

FenceEditState _updateStateReducer(FenceEditState state, Action action) {
  FenceEditState newState = state.clone();
  newState = action.payload;
  return newState;
}
FenceEditState _moveMarkerReducer(FenceEditState state, Action action) {
  final Map<String, dynamic> point = action.payload;
  final FenceEditState newState = state.clone();
  newState.toDo.linePoints[point['index']].latitude = point['latLng'].latitude;
  newState.toDo.linePoints[point['index']].longitude = point['latLng'].longitude;
  return newState;
}
FenceEditState _saveStartDragReducer(FenceEditState state, Action action) {
  final LatLng point = action.payload;
  final FenceEditState newState = state.clone();
  newState.dragStart = point;
  return newState;
}
FenceEditState _addPinReducer(FenceEditState state, Action action) {
  final LatLng point = action.payload;
  final FenceEditState newState = state.clone();
  newState.toDo.linePoints?.add(point);
  return newState;
}
FenceEditState _removeMarkerReducer(FenceEditState state, Action action) {
  final LatLng point = action.payload;
  final FenceEditState newState = state.clone();
  newState.toDo.linePoints?.removeWhere((LatLng e) => e == point);
  return newState;
}
