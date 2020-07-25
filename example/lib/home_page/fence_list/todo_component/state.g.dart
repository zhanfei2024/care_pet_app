// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoState _$ToDoStateFromJson(Map<String, dynamic> json) {
  return ToDoState(
    id: json['id'] as int,
    fence_name: json['fence_name'] as String,
    fence_desc: json['fence_desc'] as String,
    fence_status: json['fence_status'] as int,
    fence_positions: json['fence_positions'] as String,
    device_id: json['device_id'] as int,
    mapStyle: json['mapStyle'] as int,
    accuracy: json['accuracy'] as num,
  );
}

Map<String, dynamic> _$ToDoStateToJson(ToDoState instance) => <String, dynamic>{
      'id': instance.id,
      'fence_name': instance.fence_name,
      'fence_desc': instance.fence_desc,
      'fence_status': instance.fence_status,
      'fence_positions': instance.fence_positions,
      'device_id': instance.device_id,
      'mapStyle': instance.mapStyle,
      'accuracy': instance.accuracy,
    };
