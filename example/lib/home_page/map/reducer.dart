import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<MapState> buildReducer() {
  return asReducer(<Object, Reducer<MapState>>{
  });
}