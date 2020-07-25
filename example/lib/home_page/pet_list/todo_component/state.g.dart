// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoState _$ToDoStateFromJson(Map<String, dynamic> json) {
  return ToDoState(
    id: json['id'] as int,
    pet_avatar: json['pet_avatar'] as String,
    pet_name: json['pet_name'] as String,
    pet_gender: json['pet_gender'] as int,
    pet_age: json['pet_age'] as int,
    pet_step: json['pet_step'] as int,
    pet_status: json['pet_status'] as int,
    isBindDevice: json['isBindDevice'] as bool,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$ToDoStateToJson(ToDoState instance) => <String, dynamic>{
      'id': instance.id,
      'pet_avatar': instance.pet_avatar,
      'pet_name': instance.pet_name,
      'pet_gender': instance.pet_gender,
      'pet_age': instance.pet_age,
      'pet_step': instance.pet_step,
      'pet_status': instance.pet_status,
      'isBindDevice': instance.isBindDevice,
      'index': instance.index,
    };
