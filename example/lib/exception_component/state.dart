import 'package:fish_redux/fish_redux.dart';

class ExceptionState implements Cloneable<ExceptionState> {
  ExceptionState({this.msg});
  String msg;

  
  @override
  ExceptionState clone() {
    // TODO(zhanfei): message, implement clone.
    return ExceptionState()
      ..msg = msg;
  }
}