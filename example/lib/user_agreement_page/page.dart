import 'package:fish_redux/fish_redux.dart';
import './state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';

class UserAgreeMentPage extends Page<UserAgreeMentState, Map<String, dynamic>> {
    UserAgreeMentPage():
        super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          reducer: buildReducer(),
      );
        
}

