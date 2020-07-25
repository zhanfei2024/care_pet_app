// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterState _$RegisterStateFromJson(Map<String, dynamic> json) {
  return RegisterState(
    username: json['username'] as String,
    password: json['password'] as String,
    agreementStatus: json['agreementStatus'] as bool,
    showPassword: json['showPassword'] as bool,
  );
}

Map<String, dynamic> _$RegisterStateToJson(RegisterState instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'agreementStatus': instance.agreementStatus,
      'showPassword': instance.showPassword,
    };
