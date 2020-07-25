// ignore_for_file: non_constant_identifier_names, avoid_as

import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
enum NetWorkDisconnectAction {
  update,
  onCallPhone,
  onAgree,
  onRefuse
}

class NetWorkDisconnectActionCreator {
  static Action updateAction(NetWorkDisconnectState value) {
    return Action(
      NetWorkDisconnectAction.update,
      payload: value
    );
  }
  static Action onCallPhoneAction(String phone_number) {
    return Action(
      NetWorkDisconnectAction.onCallPhone,
      payload: phone_number
    );
  }
  static Action onAgreeAction() {
    return const Action(
      NetWorkDisconnectAction.onAgree,
    );
  }
  static Action onRefuseAction() {
    return const Action(
      NetWorkDisconnectAction.onRefuse,
    );
  }
}