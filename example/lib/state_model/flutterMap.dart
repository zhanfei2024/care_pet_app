
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';


class FlutterMapState implements Cloneable<FlutterMapState> {
  LatLng currentLatLang;
  int mapStyle;
  String mapType;
  double accuracy;
  MapController mapController;
  @override
  FlutterMapState clone() {
    return FlutterMapState()
      ..currentLatLang = currentLatLang
      ..mapStyle = mapStyle
      ..mapType = mapType
      ..accuracy = accuracy
      ..mapController = mapController;
  }
}