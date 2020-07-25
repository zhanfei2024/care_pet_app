import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()

class NetWorkDisconnectState implements Cloneable<NetWorkDisconnectState> {
  NetWorkDisconnectState({this.title, this.content, this.hideButton = true, this.count = 4, this.agreement});
  factory NetWorkDisconnectState.fromJson(Map<String, dynamic> json) {
    return _$NetWorkDisconnectStateFromJson(json);
  }
  String title;
  dynamic content;
  bool hideButton;
  int count;
  String agreement;

  
  @override
  NetWorkDisconnectState clone() {
    // TODO(zhanfei): message, implement clone.
    return NetWorkDisconnectState()
            ..title = title
            ..content = content
            ..hideButton = hideButton
            ..count = count
            ..agreement = agreement;
  }

  

  Map<String, dynamic> toJson() => _$NetWorkDisconnectStateToJson(this);
  
}

NetWorkDisconnectState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return NetWorkDisconnectState();
}