
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Res.g.dart';

@JsonSerializable()
class ResState implements Cloneable<ResState> {
  ResState({this.code, this.msg, this.data});
  int code;
  String msg;
  dynamic data;
  
  @override
  ResState clone() {
    return ResState()
      ..code = code
      ..msg = msg
      ..data = data;
  }

  factory ResState.fromJson(Map<String, dynamic> json) {
    return _$ResStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResStateToJson(this);
}