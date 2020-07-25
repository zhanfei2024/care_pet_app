// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResState _$ResStateFromJson(Map<String, dynamic> json) {
  return ResState(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: json['data'],
  );
}

Map<String, dynamic> _$ResStateToJson(ResState instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
