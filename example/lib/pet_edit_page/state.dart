import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:latlong/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/home_page/pet_list/todo_component/state.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:sample/state_model/picker.dart';
import 'package:sample/state_model/user.dart';

import '../global_store/state.dart';

class PetEditState implements GlobalBaseState, Cloneable<PetEditState> {
  ToDoState toDo;

  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController genderController;

  FocusNode focusNodeName;
  FocusNode focusNodeDesc;

  TextEditingController maxWidthController;
  TextEditingController maxHeightController;
  TextEditingController qualityController;
  ImagePicker picker;
  String retrieveDataError;
  dynamic pickImageError;
  PickedFile imageFile;
  double uploadPercent;
  bool isAddDevice;


  List<PickerState> genders;

  @override
  Color themeColor;
  @override
  FlutterMapState flutterMapState;

  @override
  UserState userState;

  @override
  LatLng currentLocation;

  @override
  PetEditState clone() {
    return PetEditState()
      ..nameController = nameController
      ..ageController = ageController
      ..genderController = genderController
      ..focusNodeName = focusNodeName
      ..focusNodeDesc = focusNodeDesc
      ..maxWidthController = maxWidthController
      ..maxHeightController = maxHeightController
      ..qualityController = qualityController
      ..picker = picker
      ..retrieveDataError = retrieveDataError
      ..pickImageError = pickImageError
      ..imageFile = imageFile
      ..uploadPercent = uploadPercent
      ..isAddDevice = isAddDevice
      ..genders = genders
      ..toDo = toDo
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }
}

PetEditState initState(ToDoState arg) {
  final PetEditState state = PetEditState();
  state.toDo = arg?.clone() ?? ToDoState();
  if (arg == null) {
    state.isAddDevice = true;
  } else {
    state.isAddDevice = false;
  }
  state.nameController = TextEditingController(text: arg?.pet_name);
  state.ageController = TextEditingController(text: arg?.pet_age?.toString());
  state.genderController = TextEditingController(text: arg?.pet_gender?.toString());
  state.focusNodeName = FocusNode();
  state.focusNodeDesc = FocusNode();
  state.maxWidthController = TextEditingController();
  state.maxHeightController = TextEditingController();
  state.qualityController = TextEditingController();
  state.picker = ImagePicker();

  return state;
}
