import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<ProfileState> buildReducer() {
  return asReducer(<Object, Reducer<ProfileState>>{
  });
}