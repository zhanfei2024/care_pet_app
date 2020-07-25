// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoState _$ToDoStateFromJson(Map<String, dynamic> json) {
  return ToDoState(
    id: json['id'] as int,
    auth_id: json['auth_id'] as int,
    device_name: json['device_name'] as String,
    device_imei: json['device_imei'] as String,
    device_iccid: json['device_iccid'] as String,
    device_status: json['device_status'] as int,
    current_latitude: (json['current_latitude'] as num)?.toDouble(),
    current_longitude: (json['current_longitude'] as num)?.toDouble(),
    device_version: json['device_version'] as String,
    electric_quantity: json['electric_quantity'] as int,
    pet_id: json['pet_id'] as int,
    isDone: json['isDone'] as bool,
  );
}

Map<String, dynamic> _$ToDoStateToJson(ToDoState instance) => <String, dynamic>{
      'id': instance.id,
      'auth_id': instance.auth_id,
      'device_name': instance.device_name,
      'device_imei': instance.device_imei,
      'device_iccid': instance.device_iccid,
      'device_status': instance.device_status,
      'current_latitude': instance.current_latitude,
      'current_longitude': instance.current_longitude,
      'device_version': instance.device_version,
      'electric_quantity': instance.electric_quantity,
      'pet_id': instance.pet_id,
      'isDone': instance.isDone,
    };
