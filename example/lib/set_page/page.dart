import 'package:fish_redux/fish_redux.dart';
import 'package:sample/set_page/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'view.dart';


class SetPage extends Page<SetState, Map<String, dynamic>> {
  SetPage()
      : super(
          initState: initState,
          view: buildView,
          effect: buildEffect(),
          reducer: buildReducer(),
        );
}
