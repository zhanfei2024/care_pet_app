// ignore_for_file: non_constant_identifier_names, avoid_as
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class LoginState implements Cloneable<LoginState> {
  String username;
  String password;
  bool obscure;

  LoginState({this.username, this.password, this.obscure = true});

  @override
  LoginState clone() {
    // TODO: implement clone
    return LoginState()
      ..username = username
      ..password= password
      ..obscure = obscure;
  }

  factory LoginState.fromJson(Map<String, dynamic> json) {
    return _$LoginStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginStateToJson(this);
  
}

LoginState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return LoginState();
}