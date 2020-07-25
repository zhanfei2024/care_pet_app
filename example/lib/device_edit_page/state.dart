import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/device_page/todo_component/state.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:sample/state_model/picker.dart';
import 'package:sample/state_model/user.dart';

import '../global_store/state.dart';

class DeviceEditState implements GlobalBaseState, Cloneable<DeviceEditState> {
  ToDoState toDo;
  List<PickerState> pickerState;
  TextEditingController nameEditController;
  TextEditingController imeiEditController;
  TextEditingController iccidEditController;
  TextEditingController petEditController;
  bool isAddDevice;

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
  DeviceEditState clone() {
    return DeviceEditState()
      ..toDo = toDo
      ..pickerState = pickerState
      ..nameEditController = nameEditController
      ..imeiEditController = imeiEditController
      ..iccidEditController = iccidEditController
      ..petEditController = petEditController
      ..isAddDevice = isAddDevice
      ..focusNodeName = focusNodeName
      ..focusNodeDesc = focusNodeDesc
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }
}

DeviceEditState initState(ToDoState arg) {
  final DeviceEditState state = DeviceEditState();
  state.toDo = arg?.clone() ?? ToDoState();
  if( arg == null) {
    state.isAddDevice = true;
    state.petEditController = TextEditingController(text: '');
  } else {
    state.isAddDevice = false;
    state.petEditController = TextEditingController(text: arg?.pet_name);
  }
  state.nameEditController = TextEditingController(text: arg?.device_name);
  state.imeiEditController = TextEditingController(text: arg?.device_imei);
  state.iccidEditController = TextEditingController(text: arg?.device_iccid);
  
  state.focusNodeName = FocusNode();
  state.focusNodeDesc = FocusNode();

  return state;
}
