import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/home_page/fence_list/todo_component/state.dart' as fence_state;

class MapState implements Cloneable<MapState> {
  String test;
  LatLng currentLatLang;
  List<LatLng> travel;
  List<fence_state.ToDoState> fenceList;
  int mapStyle;
  String mapType;
  num accuracy;
  MapController mapController;
  LatLng petLatLng;

  MapState({this.test, this.currentLatLang, this.travel, this.fenceList, this.mapStyle, this.mapType, this.accuracy, this.mapController, this.petLatLng}) {
    test ??= 'hah';
    travel ??= <LatLng>[];
  }

  @override
  MapState clone() {
    return MapState()
      ..test = test
      ..currentLatLang = currentLatLang
      ..travel = travel
      ..fenceList = fenceList
      ..mapStyle = mapStyle
      ..mapType = mapType
      ..accuracy = accuracy
      ..mapController = mapController
      ..petLatLng = petLatLng;
  }
}
