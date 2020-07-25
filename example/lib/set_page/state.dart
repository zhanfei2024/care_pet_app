import 'package:fish_redux/fish_redux.dart';

class SetState implements Cloneable<SetState> {
  String test;

  SetState({this.test}) {
    test ??= 'hah';
  }

  @override
  SetState clone() {
    return SetState()
      ..test = test;
  }

}
SetState initState(Map<String, dynamic> arg) { 
  return SetState();
}