
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/home_page/fence_list/todo_component/state.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/state_model/picker.dart';
import 'package:sample/state_model/user.dart';

import '../global_store/state.dart';

class FenceEditState implements GlobalBaseState, Cloneable<FenceEditState> {
  ToDoState toDo;

  TextEditingController deviceEditController;
  TextEditingController nameEditController;
  TextEditingController descEditController;

  FocusNode focusNodeDevice;
  FocusNode focusNodeName;
  FocusNode focusNodeDesc;
  List<PickerState> pickerState;

  LatLng dragStart;
  bool isAddFence;



  

  @override
  Color themeColor;
  @override
  FlutterMapState flutterMapState;
  @override
  UserState userState;
  @override
  LatLng currentLocation;

  @override
  FenceEditState clone() {
    return FenceEditState()
      ..deviceEditController = deviceEditController
      ..nameEditController = nameEditController
      ..descEditController = descEditController
      ..focusNodeDevice = focusNodeDevice
      ..focusNodeName = focusNodeName
      ..focusNodeDesc = focusNodeDesc
      ..dragStart = dragStart
      ..isAddFence = isAddFence
      ..pickerState = pickerState
      ..toDo = toDo
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }
}

FenceEditState initState(ToDoState arg) {
  final FenceEditState state = FenceEditState();
  state.toDo = arg?.clone() ?? ToDoState();
  if(arg == null) {
    state.isAddFence = true;
  } else {
    state.isAddFence = false;
  }
  state.deviceEditController = TextEditingController(text: '');
  state.nameEditController = TextEditingController(text: arg?.fence_name);
  state.descEditController = TextEditingController(text: arg?.fence_desc);
  state.focusNodeDevice = FocusNode();
  state.focusNodeName = FocusNode();
  state.focusNodeDesc = FocusNode();

  return state;
}