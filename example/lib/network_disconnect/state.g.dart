// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetWorkDisconnectState _$NetWorkDisconnectStateFromJson(
    Map<String, dynamic> json) {
  return NetWorkDisconnectState(
    title: json['title'] as String,
    content: json['content'],
    hideButton: json['hideButton'] as bool,
    count: json['count'] as int,
    agreement: json['agreement'] as String,
  );
}

Map<String, dynamic> _$NetWorkDisconnectStateToJson(
        NetWorkDisconnectState instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'hideButton': instance.hideButton,
      'count': instance.count,
      'agreement': instance.agreement,
    };
