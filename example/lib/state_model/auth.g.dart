// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return AuthState(
    id: json['id'] as int,
    profile: json['profile'] == null
        ? null
        : ProfileState.fromJson(json['profile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'id': instance.id,
      'profile': instance.profile,
    };
