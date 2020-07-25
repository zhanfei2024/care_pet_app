// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginState _$LoginStateFromJson(Map<String, dynamic> json) {
  return LoginState(
    username: json['username'] as String,
    password: json['password'] as String,
    obscure: json['obscure'] as bool,
  );
}

Map<String, dynamic> _$LoginStateToJson(LoginState instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'obscure': instance.obscure,
    };
