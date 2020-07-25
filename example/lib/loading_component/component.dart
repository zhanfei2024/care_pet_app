import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

export 'state.dart';
class LoadingComponent extends Component<LoadingState> {
  LoadingComponent()
    :super(
      view: buildView,
      // effect: buildEffect(),
    );
}