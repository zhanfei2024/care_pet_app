import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import '../action.dart' as home_action;
import 'action.dart';
import 'state.dart';

Effect<PetListState> buildEffect() {
  return combineEffects(<Object, Effect<PetListState>>{
    Lifecycle.initState: _init,
    PetListAction.onAdd:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<PetListState>>(_onAdd),
  });
}

void _init(Action action, Context<PetListState> ctx) async{
  


}

void _onAdd(Action action, Context<PetListState> ctx) {
  Navigator.of(ctx.context)
      .pushNamed('pet_edit', arguments: null)
      .then((dynamic toDo) {
    if (toDo != null && toDo.pet_name?.isNotEmpty == true) {
          ctx.dispatch(home_action.HomeActionCreator.addPetAction(toDo));
        }
  });
}

