// ignore_for_file: non_constant_identifier_names, avoid_as

import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum UserAgreeMentAction {
  update,
  onCallPhone,
  onAgree,
  onRefuse
}

class UserAgreeMentActionCreator {
  static Action updateAction(UserAgreeMentState value) {
    return Action(
      UserAgreeMentAction.update,
      payload: value
    );
  }
  static Action onCallPhoneAction(String phone_number) {
    return Action(
      UserAgreeMentAction.onCallPhone,
      payload: phone_number
    );
  }
  static Action onAgreeAction() {
    return const Action(
      UserAgreeMentAction.onAgree,
    );
  }
  static Action onRefuseAction() {
    return const Action(
      UserAgreeMentAction.onRefuse,
    );
  }
}