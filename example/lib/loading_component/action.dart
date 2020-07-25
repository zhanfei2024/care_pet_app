import 'package:fish_redux/fish_redux.dart';

enum LoadingAction {
  onToDetail
}
class LoadingActionCreator {
  static Action onToDetailAction(int id) {
    return Action(
      LoadingAction.onToDetail,
      payload: id
    );
  }
}