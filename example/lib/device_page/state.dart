import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/exception_component/state.dart';
import 'package:sample/global_store/state.dart';
import 'package:sample/loading_component/state.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:sample/state_model/user.dart';
import 'todo_component/state.dart';


class DeviceState extends MutableSource implements GlobalBaseState, Cloneable<DeviceState> {
  DeviceState({this.toDos, this.devicesPageNum, this.devicesPageLimit, this.isDevicesLoading, this.isDevicesEmpty, this.isLastPageNum, this.msg, this.maxScrollExtent, this.showLastEnd, this.showMoreLoading, this.themeColor,
  this.flutterMapState, this.userState, this.currentLocation}){
    devicesPageNum = 1;
    devicesPageLimit = 5;
    isDevicesLoading = true;
    isDevicesEmpty = true;
    maxScrollExtent = 0;
    showLastEnd = false;
    showMoreLoading = false;
    isLastPageNum = false;
    msg = '暂无设备，请点击右上角添加';
  }
  List<ToDoState> toDos;
  int devicesPageNum;
  int devicesPageLimit;
  bool isDevicesLoading;
  bool isDevicesEmpty;
  bool isLastPageNum;
  String msg;
  double maxScrollExtent;
  bool showLastEnd;
  bool showMoreLoading;

  @override
  Color themeColor;
  @override
  FlutterMapState flutterMapState;
  @override
  UserState userState;
  @override
  LatLng currentLocation;


  @override
  DeviceState clone() {
    return DeviceState()
      ..toDos = toDos
      ..devicesPageNum = devicesPageNum
      ..devicesPageLimit = devicesPageLimit
      ..isDevicesLoading = isDevicesLoading
      ..isDevicesEmpty = isDevicesEmpty
      ..maxScrollExtent = maxScrollExtent
      ..isLastPageNum = isLastPageNum
      ..msg = msg
      ..showLastEnd = showLastEnd
      ..showMoreLoading = showMoreLoading
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }

  @override
  Object getItemData(int index) => toDos[index];

  @override
  String getItemType(int index) => 'toDo';

  @override
  int get itemCount => toDos?.length ?? 0;

  @override
  void setItemData(int index, Object data) => toDos[index] = data;
}

DeviceState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return DeviceState()
  ..toDos = <ToDoState>[];
}

class LoadingConnector extends ConnOp<DeviceState, LoadingState>{
  @override
  LoadingState get(DeviceState state) {
    final LoadingState cub = LoadingState();
    cub.isLoading= state.isDevicesLoading;
    return cub;
  }

  @override
  void set(DeviceState state, LoadingState subState) {
    state.isDevicesLoading = subState.isLoading;
  }
  /* @override
  LoadingState computed(DeviceState state) {
    return LoadingState()
      ..done = state.toDos.where((ToDoState tds) => tds.isDone).length
      ..total = state.toDos.length;
  }

  @override
  List<dynamic> factors(DeviceState state) {
    return <int>[
      state.toDos.where((ToDoState tds) => tds.isDone).length,
      state.toDos.length
    ];
  }

  @override
  void set(DeviceState state, LoadingState subState) {
    throw Exception('Unexcepted to set DeviceState from LoadingState');
  } */
}
class ExceptionConnector extends ConnOp<DeviceState, ExceptionState>{
  @override
  ExceptionState get(DeviceState state) {
    final ExceptionState cub = ExceptionState();
    cub.msg= state.msg;
    return cub;
  }

  @override
  void set(DeviceState state, ExceptionState subState) {
    state.msg = subState.msg;
  }
}
