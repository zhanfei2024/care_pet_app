// ignore_for_file: non_constant_identifier_names, avoid_as
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class ModifyPasswordState implements Cloneable<ModifyPasswordState> {
  int currentIndex;

  bool isHomeLoading;
  bool isHomeEmpty;
  
  bool isCategoryLoading;
  bool isCategoryEmpty;
  
  bool isSubjectLoading;
  bool isSubjectEmpty;
  
  bool isMemberLoading;
  bool isMemberEmpty;
  

  ModifyPasswordState({this.currentIndex = 0, this.isHomeLoading = true, this.isHomeEmpty = true, this.isCategoryLoading = true, this.isCategoryEmpty = true,
  this.isSubjectLoading = true, this.isSubjectEmpty = true, this.isMemberLoading = true, this.isMemberEmpty = true });

  @override
  ModifyPasswordState clone() {
    // TODO: implement clone
    return ModifyPasswordState()
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

  /* factory ModifyPasswordState.fromJson(Map<String, dynamic> json) {
    return _$ModifyPasswordStateFromJson(json);
  } */

  // Map<String, dynamic> toJson() => _$ModifyPasswordStateToJson(this);
  
}

ModifyPasswordState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return ModifyPasswordState();
}