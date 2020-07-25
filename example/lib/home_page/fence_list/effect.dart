import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/home_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<FenceListState> buildEffect() {
  return combineEffects(<Object, Effect<FenceListState>>{
    Lifecycle.initState: _init,
    FenceListAction.onAdd:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<FenceListState>>(_onAdd),
  });
}

void _init(Action action, Context<FenceListState> ctx) async{
}

void _onAdd(Action action, Context<FenceListState> ctx) {
  Navigator.of(ctx.context)
      .pushNamed('fence_edit', arguments: null)
      .then((dynamic toDo) {
    if (toDo != null &&
        (toDo.fence_name?.isNotEmpty == true || toDo.fence_desc?.isNotEmpty == true)) {
      ctx.dispatch(HomeActionCreator.addFenceAction(toDo));
    }
  });
}

