import 'package:fish_redux/fish_redux.dart';
import 'package:sample/device_page/state.dart';

enum PageAction {onAdd, updataState, onRefreshDevice, onLoadMore, onShowLastEnd }

class PageActionCreator {
  static Action onAddAction() {
    return const Action(PageAction.onAdd);
  }
  static Action updataStateAction(DeviceState v) {
    return
     Action(
       PageAction.updataState,
       payload: v
    );
  }
  static Action onRefreshDeviceAction() {
    return
    const Action(
       PageAction.onRefreshDevice,
    );
  }
  static Action onLoadMoreAction(double position) {
    return Action(
       PageAction.onLoadMore,
       payload: position
    );
  }
  static Action onShowLastEndAction() {
    return const Action(
       PageAction.onShowLastEnd,
    );
  }
}
