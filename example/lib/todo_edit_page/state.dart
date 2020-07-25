import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/state_model/flutterMap.dart';
import 'package:sample/state_model/user.dart';

import '../global_store/state.dart';
import '../todo_list_page/todo_component/component.dart';

class TodoEditState implements GlobalBaseState, Cloneable<TodoEditState> {
  ToDoState toDo;

  TextEditingController nameEditController;
  TextEditingController descEditController;

  FocusNode focusNodeName;
  FocusNode focusNodeDesc;

  @override
  Color themeColor;
  @override
  FlutterMapState flutterMapState;

  @override
  UserState userState;

  @override
  LatLng currentLocation;

  @override
  TodoEditState clone() {
    return TodoEditState()
      ..nameEditController = nameEditController
      ..descEditController = descEditController
      ..focusNodeName = focusNodeName
      ..focusNodeDesc = focusNodeDesc
      ..toDo = toDo
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }
}

TodoEditState initState(ToDoState arg) {
  final TodoEditState state = TodoEditState();
  state.toDo = arg?.clone() ?? ToDoState();
  state.nameEditController = TextEditingController(text: arg?.title);
  state.descEditController = TextEditingController(text: arg?.desc);
  state.focusNodeName = FocusNode();
  state.focusNodeDesc = FocusNode();

  return state;
}
