// ignore_for_file: non_constant_identifier_names, avoid_as
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class ModifyPhoneState implements Cloneable<ModifyPhoneState> {
  int currentIndex;

  bool isHomeLoading;
  bool isHomeEmpty;
  
  bool isCategoryLoading;
  bool isCategoryEmpty;
  
  bool isSubjectLoading;
  bool isSubjectEmpty;
  
  bool isMemberLoading;
  bool isMemberEmpty;
  

  ModifyPhoneState({this.currentIndex = 0, this.isHomeLoading = true, this.isHomeEmpty = true, this.isCategoryLoading = true, this.isCategoryEmpty = true,
  this.isSubjectLoading = true, this.isSubjectEmpty = true, this.isMemberLoading = true, this.isMemberEmpty = true });

  @override
  ModifyPhoneState clone() {
    // TODO: implement clone
    return ModifyPhoneState()
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

  /* factory ModifyPhoneState.fromJson(Map<String, dynamic> json) {
    return _$ModifyPhoneStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ModifyPhoneStateToJson(this); */
  
}

ModifyPhoneState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return ModifyPhoneState();
}