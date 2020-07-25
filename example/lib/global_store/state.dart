import 'dart:ui';

import 'package:latlong/latlong.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:sample/state_model/user.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  FlutterMapState get flutterMapState;
  set flutterMapState(FlutterMapState v);

  UserState get userState;
  set userState(UserState v);

  LatLng get currentLocation;
  set currentLocation(LatLng v);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  FlutterMapState flutterMapState;

  @override
  UserState userState;

  @override
  LatLng currentLocation;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }
}
