import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class MeComponent extends Component<ProfileState> {
  MeComponent()
      : super(
          view: buildView,
          effect: buildEffect(),
          reducer: buildReducer(),
        );
}
