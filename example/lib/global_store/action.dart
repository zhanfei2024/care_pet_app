import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/state_model/auth.dart';
import 'package:sample/state_model/flutterMap.dart';

enum GlobalAction { changeThemeColor, changeFlutterMap, saveToken, changeCurrentLocation, saveAuth }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }
  static Action onchangeFlutterMap(FlutterMapState v) {
    return Action(
      GlobalAction.changeFlutterMap,
      payload: v
    );
  }
  static Action onsaveToken(String v) {
    return Action(
      GlobalAction.saveToken,
      payload: v
    );
  }
  static Action onsaveAuth(AuthState v) {
    return Action(
      GlobalAction.saveAuth,
      payload: v
    );
  }
  static Action onchangeCurrentLocation(LatLng v) {
    return Action(
      GlobalAction.changeCurrentLocation,
      payload: v
    );
  }
}
