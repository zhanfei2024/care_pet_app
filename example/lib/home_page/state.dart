import 'dart:async';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/home_page/fence_list/todo_component/state.dart' as fence_state;

import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:sample/home_page/map/component.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/state_model/user.dart';

import '../global_store/state.dart';
import 'fence_list/state.dart';
import 'fence_list/todo_component/state.dart' as fence;
import 'me/state.dart';
import 'pet_list/state.dart';
import 'pet_list/todo_component/state.dart' as pet;

class HomeState implements GlobalBaseState, Cloneable<HomeState> {

  HomeState({this.appBarName, this.componentName, this.test, this.travel, this.fenceList, this.fenceMaxScrollExtent,
    this.fencePageNum = 1, this.fencePageLimit = 10, this.isFenceLoading = true, this.isFenceEmpty = true, this.fenceMsg,
     this.petList, this.petPageNum = 1,
    this.petPageLimit = 10, this.isPetLoading = true, this.isPetEmpty = true, this.petMsg, this.currentLocationSubscription,
    this.connectivitySubscription,
    this.profileState, this.themeColor, this.flutterMapState, this.userState, this.currentLocation}) {
      fenceMsg = '暂无围栏，请点击右上角添加';
      petMsg = '暂无宠物，请点击右上角添加';
  }

  String appBarName;
  String componentName;

  String test;
  List<LatLng> travel;
  List<fence.ToDoState> fenceList;
  double fenceMaxScrollExtent;
  int fencePageNum;
  int fencePageLimit;
  bool isFenceLoading;
  bool isFenceEmpty;
  String fenceMsg;


  List<pet.ToDoState> petList;
  double petMaxScrollExtent;
  int petPageNum;
  int petPageLimit;
  bool isPetLoading;
  bool isPetEmpty;
  String petMsg;
  
  StreamSubscription<Location> currentLocationSubscription;
  // Connectivity subscription
  StreamSubscription<ConnectivityResult> connectivitySubscription;



  ProfileState profileState;

  @override
  Color themeColor;
  @override
  FlutterMapState flutterMapState;
  @override
  UserState userState;
  @override
  LatLng currentLocation;

  @override
  HomeState clone() {
    return HomeState()
      ..appBarName = appBarName
      ..componentName = componentName
      ..test = test
      ..travel = travel
      ..fenceList = fenceList
      ..fencePageNum = fencePageNum
      ..fencePageLimit = fencePageLimit
      ..isFenceLoading = isFenceLoading
      ..isFenceEmpty = isFenceEmpty
      ..fenceMsg = fenceMsg
      ..petList = petList
      ..petPageNum = petPageNum
      ..petPageLimit = petPageLimit
      ..isPetLoading = isPetLoading
      ..isPetEmpty = isPetEmpty
      ..petMsg = petMsg
      ..currentLocationSubscription = currentLocationSubscription
      ..connectivitySubscription = connectivitySubscription
      ..profileState = profileState
      ..themeColor = themeColor
      ..flutterMapState = flutterMapState
      ..userState = userState
      ..currentLocation = currentLocation;
  }
}

HomeState initState(Map<String, dynamic> arg) {
  final HomeState state = HomeState();
  state.appBarName = 'mapBar';
  state.componentName = arg == null ? 'pet_list' : arg['componentName'];
  state.travel = <LatLng>[
      LatLng(22.731728,114.247207),
      LatLng(22.731783,114.248993),
      LatLng(22.731026,114.249063),
      LatLng(22.730640,114.247266),
      LatLng(22.731798,114.247223),
    ];
  state.fenceList = <fence_state.ToDoState>[];
  state.petList = <pet.ToDoState>[];
  state.profileState = ProfileState();
  state.flutterMapState = FlutterMapState();
  state.flutterMapState.mapController = MapController();
  return state;
}


class MapConnector extends ConnOp<HomeState, MapState>{
  @override
  MapState get(HomeState state) {
    final MapState cub = MapState();
    cub.fenceList = state.fenceList;
    cub.test= state.test;
    cub.travel = state.travel;
    cub.currentLatLang = state.flutterMapState?.currentLatLang;
    cub.mapStyle = state.flutterMapState?.mapStyle;
    cub.mapType = state.flutterMapState?.mapType;
    cub.accuracy = state.flutterMapState?.accuracy;
    cub.mapController = state.flutterMapState?.mapController ?? MapController();
    cub.petLatLng = state.currentLocation;
    return cub;
  }

  @override
  void set(HomeState state, MapState subState) {
    state.fenceList = subState.fenceList;
    state.test = subState.test;
    state.travel = subState.travel;
    state.flutterMapState.currentLatLang = subState.currentLatLang;
    state.flutterMapState.mapStyle = subState.mapStyle;
    state.flutterMapState.mapType = subState.mapType;
    state.flutterMapState.accuracy = subState.accuracy;
    state.flutterMapState.mapController = subState.mapController;
    state.currentLocation = subState.petLatLng;
    throw Exception('Unexcepted to set PageState from ReportState');
  }
}

class FenceListConnector extends ConnOp<HomeState, FenceListState>{
  @override
  FenceListState get(HomeState state) {
    final FenceListState cub = FenceListState();
    cub.toDos = state.fenceList;
    cub.loading = state.isFenceLoading;
    cub.empty = state.isFenceEmpty;
    cub.msg = state.fenceMsg;
    return cub;
  }
  @override
  void set(HomeState state, FenceListState subState) {
    state.fenceList = subState.toDos;
    state.isFenceLoading = subState.loading ?? false;
    state.isFenceEmpty = subState.empty ?? false;
    state.fenceMsg = subState.msg ?? '暂无围栏，请点击右上角添加';
  }
}
class PetListConnector extends ConnOp<HomeState, PetListState>{
  @override
  PetListState get(HomeState state) {
    final PetListState cub = PetListState();
    cub.toDos = state.petList;
    cub.pageNum = state.petPageNum;
    cub.pageLimit = state.petPageLimit;
    cub.isLoading = state.isPetLoading;
    cub.isEmpty = state.isPetEmpty;
    cub.msg = state.petMsg; 
    return cub;
  }
  @override
  void set(HomeState state, PetListState subState) {
    state.petList = subState.toDos;
    state.petPageNum = subState.pageNum;
    state.petPageLimit = subState.pageLimit;
    state.isPetLoading = subState.isLoading;
    state.isPetEmpty = subState.isEmpty;
    state.petMsg = subState.msg;
    throw Exception('Unexcepted to set PageState from ReportState');
  }
}


class MeConnector extends ConnOp<HomeState, ProfileState>{
  @override
  ProfileState get(HomeState state) {
    ProfileState cub = ProfileState();
    cub = state.profileState;
    return cub;
  }

  @override
  void set(HomeState state, ProfileState subState) {
    state.profileState = subState;
    throw Exception('Unexcepted to set PageState from ReportState');
  }
}
