import 'package:fish_redux/fish_redux.dart';

class LoadingState implements Cloneable<LoadingState> {
  LoadingState({this.isLoading});
  bool isLoading;
  
  @override
  LoadingState clone() {
    // TODO(zhanfei): message, implement clone.
    return LoadingState()
      ..isLoading = isLoading;
  }
}