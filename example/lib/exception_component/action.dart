import 'package:fish_redux/fish_redux.dart';

enum ExceptionAction {
  onToDetail
}
class ExceptionActionCreator {
  static Action onToDetailAction(int id) {
    return Action(
      ExceptionAction.onToDetail,
      payload: id
    );
  }
}