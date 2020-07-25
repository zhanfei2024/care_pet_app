// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileState _$ProfileStateFromJson(Map<String, dynamic> json) {
  return ProfileState(
    id: json['id'] as int,
    avatarImageURL: json['avatarImageURL'] as String,
    email: json['email'] as String,
    gender: json['gender'] as int,
    age: json['age'] as int,
    birthday: json['birthday'] as int,
  );
}

Map<String, dynamic> _$ProfileStateToJson(ProfileState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatarImageURL': instance.avatarImageURL,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'birthday': instance.birthday,
    };
