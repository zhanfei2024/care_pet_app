import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

export 'state.dart';
class ExceptionComponent extends Component<ExceptionState> {
  ExceptionComponent()
    :super(
      view: buildView,
      // effect: buildEffect(),
    );
}