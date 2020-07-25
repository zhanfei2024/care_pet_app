// ignore_for_file: non_constant_identifier_names, avoid_as
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class RegisterState implements Cloneable<RegisterState> {
  String username;
  String password;
  bool agreementStatus;
  bool showPassword;
  

  RegisterState({this.username, this.password, this.agreementStatus = false , this.showPassword = false});

  @override
  RegisterState clone() {
    // TODO: implement clone
    return RegisterState()
      ..username = username
      ..password = password
      ..agreementStatus = agreementStatus
      ..showPassword = showPassword;
  }

  factory RegisterState.fromJson(Map<String, dynamic> json) {
    return _$RegisterStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterStateToJson(this);
  
}

RegisterState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return RegisterState();
}