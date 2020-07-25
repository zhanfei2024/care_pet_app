import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:location/location.dart';
import 'action.dart';
import 'state.dart';

Effect<MapState> buildEffect() {
  return combineEffects(<Object, Effect<MapState>>{
    MapAction.onEdit:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<MapState>>(_onEdit),
    MapAction.onRemove:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<MapState>>(_onRemove),
  });
}



void _onEdit(Action action, Context<MapState> ctx) {
  /* if (action.payload == ctx.state.uniqueId) {
    Navigator.of(ctx.context)
        // .push<MapState>(MaterialPageRoute<MapState>(
        //     builder: (BuildContext buildCtx) =>
        //         edit_page.TodoEditPage().buildPage(ctx.state)))
        .pushNamed('todo_edit', arguments: ctx.state)
        .then((dynamic toDo) {
      if (toDo != null) {
        ctx.dispatch(MapActionCreator.editAction(toDo));
      }
    });
  } */
}

void _onRemove(Action action, Context<MapState> ctx) async {
  /* final String select = await showDialog<String>(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Are you sure to delete "${ctx.state.title}"?'),
          actions: <Widget>[
            GestureDetector(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(buildContext).pop(),
            ),
            GestureDetector(
              child: const Text('Yes', style: TextStyle(fontSize: 16.0)),
              onTap: () => Navigator.of(buildContext).pop('Yes'),
            )
          ],
        );
      });

  if (select == 'Yes') {
    ctx.dispatch(MapActionCreator.removeAction(ctx.state.uniqueId));
  } */
}

Future<LocationData> getLocation() async{
  final Location location = Location();
  return await location.getLocation();
}

