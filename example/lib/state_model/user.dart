
import 'package:fish_redux/fish_redux.dart';
import 'package:sample/state_model/auth.dart';


class UserState implements Cloneable<UserState> {
  AuthState auth;
  String token;
  @override
  UserState clone() {
    return UserState()
      ..auth = auth
      ..token = token;
  }
}