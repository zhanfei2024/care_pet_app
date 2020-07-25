import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/fence_list/todo_component/action.dart' as fence_todo_action;
import 'package:sample/home_page/fence_list/todo_component/state.dart' as fence_state;

import 'package:sample/home_page/pet_list/todo_component/action.dart' as pet_todo_action;
import 'package:sample/home_page/pet_list/todo_component/state.dart' as pet_state;


import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.updateState: _updateStateReducer,
      HomeAction.addPet: _addPetReducer,
      HomeAction.addFence: _addFenceReducer,
      fence_todo_action.ToDoAction.remove: _removeFenceReducer,
      pet_todo_action.ToDoAction.remove: _removePetReducer,
    },
  );
}

HomeState _updateStateReducer(HomeState state, Action action) {
  HomeState newState = state.clone();
  final  HomeState updateState = action.payload;
  newState = updateState;
  return newState;
}
HomeState _addFenceReducer(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.fenceList ??= <fence_state.ToDoState>[];
  newState.fenceList = (newState.fenceList.toList()..add(action.payload)).toList();
  newState.isFenceLoading = false;
  if(newState.fenceList.isNotEmpty == true) {
    newState.isFenceEmpty = false;
  } else {
    newState.isPetEmpty = true;
  }
  return newState;
}


HomeState _addPetReducer(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.petList ??= <pet_state.ToDoState>[];
  newState.petList = (newState.petList.toList()..add(action.payload)).toList();
  newState.isPetLoading = false;
  if(newState.petList.isNotEmpty == true) {
    newState.isPetEmpty = false;
  } else {
    newState.isPetEmpty = true;
  }
  return newState;
}

HomeState _removeFenceReducer(HomeState state, Action action) {
  final int id = action.payload;
  final HomeState newState = state.clone();
  newState.fenceList = newState.fenceList.toList()
    ..removeWhere((fence_state.ToDoState state) => state.id == id);
  if (newState.fenceList.isEmpty == true) {
    newState.isFenceEmpty = true;
    newState.fenceMsg = '暂无围栏数据，请点击右上角添加';
  }
  return newState;
}

HomeState _removePetReducer(HomeState state, Action action) {
  final int id = action.payload;
  final HomeState newState = state.clone();
  newState.petList = newState.petList.toList()
    ..removeWhere((pet_state.ToDoState state) => state.id == id);
  if (newState.petList.isEmpty == true) {
    newState.isPetEmpty = true;
    newState.fenceMsg = '暂无宠物数据，请点击右上角添加';
  }
  return newState;
}