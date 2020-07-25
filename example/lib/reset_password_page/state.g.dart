// ignore_for_file: avoid_as
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordState _$ResetPasswordStateFromJson(Map<String, dynamic> json) {
  return ResetPasswordState(
    currentIndex: json['currentIndex'] as int,
    isHomeLoading: json['isHomeLoading'] as bool,
    isHomeEmpty: json['isHomeEmpty'] as bool,
    isCategoryLoading: json['isCategoryLoading'] as bool,
    isCategoryEmpty: json['isCategoryEmpty'] as bool,
    isSubjectLoading: json['isSubjectLoading'] as bool,
    isSubjectEmpty: json['isSubjectEmpty'] as bool,
    isMemberLoading: json['isMemberLoading'] as bool,
    isMemberEmpty: json['isMemberEmpty'] as bool,
  );
}

Map<String, dynamic> _$ResetPasswordStateToJson(ResetPasswordState instance) =>
    <String, dynamic>{
      'currentIndex': instance.currentIndex,
      'isHomeLoading': instance.isHomeLoading,
      'isHomeEmpty': instance.isHomeEmpty,
      'isCategoryLoading': instance.isCategoryLoading,
      'isCategoryEmpty': instance.isCategoryEmpty,
      'isSubjectLoading': instance.isSubjectLoading,
      'isSubjectEmpty': instance.isSubjectEmpty,
      'isMemberLoading': instance.isMemberLoading,
      'isMemberEmpty': instance.isMemberEmpty,
    };
