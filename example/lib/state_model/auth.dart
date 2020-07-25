
import 'package:fish_redux/fish_redux.dart';
import 'package:sample/home_page/me/component.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class AuthState implements Cloneable<AuthState> {

  AuthState({this.id, this.profile});

  int id;
  ProfileState profile;

  @override
  AuthState clone() {
    return AuthState()
      ..id = id
      ..profile = profile;
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return _$AuthStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}