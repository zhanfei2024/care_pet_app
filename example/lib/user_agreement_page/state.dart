import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()

class UserAgreeMentState implements Cloneable<UserAgreeMentState> {
  UserAgreeMentState({this.title, this.content, this.hideButton = true, this.count = 4, this.agreement, this.timer});
  factory UserAgreeMentState.fromJson(Map<String, dynamic> json) {
    return _$UserAgreeMentStateFromJson(json);
  }
  String title;
  dynamic content;
  bool hideButton;
  int count;
  String agreement;
  Timer timer;

  
  @override
  UserAgreeMentState clone() {
    // TODO(zhanfei): message, implement clone.
    return UserAgreeMentState()
            ..title = title
            ..content = content
            ..hideButton = hideButton
            ..count = count
            ..agreement = agreement
            ..timer = timer;
  }

  

  Map<String, dynamic> toJson() => _$UserAgreeMentStateToJson(this);
  
}

UserAgreeMentState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return UserAgreeMentState();
}