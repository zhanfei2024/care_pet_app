// ignore_for_file: non_constant_identifier_names, avoid_as
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class ResetPasswordState implements Cloneable<ResetPasswordState> {
  int currentIndex;

  bool isHomeLoading;
  bool isHomeEmpty;
  
  bool isCategoryLoading;
  bool isCategoryEmpty;
  
  bool isSubjectLoading;
  bool isSubjectEmpty;
  
  bool isMemberLoading;
  bool isMemberEmpty;
  

  ResetPasswordState({this.currentIndex = 0, this.isHomeLoading = true, this.isHomeEmpty = true, this.isCategoryLoading = true, this.isCategoryEmpty = true,
  this.isSubjectLoading = true, this.isSubjectEmpty = true, this.isMemberLoading = true, this.isMemberEmpty = true });

  @override
  ResetPasswordState clone() {
    // TODO: implement clone
    return ResetPasswordState()
      ..currentIndex = currentIndex
      ..isHomeLoading = isHomeLoading
      ..isHomeEmpty = isHomeEmpty
      ..isCategoryLoading = isCategoryLoading
      ..isCategoryEmpty = isCategoryEmpty
      ..isSubjectLoading = isSubjectLoading
      ..isSubjectEmpty = isSubjectEmpty
      ..isMemberLoading = isMemberLoading
      ..isMemberEmpty = isMemberEmpty;
  }

  factory ResetPasswordState.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResetPasswordStateToJson(this);
  
}

ResetPasswordState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return ResetPasswordState();
}