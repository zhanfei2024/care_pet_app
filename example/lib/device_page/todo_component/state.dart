// ignore_for_file: non_constant_identifier_names
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class ToDoState implements Cloneable<ToDoState> {
  int id;
  int auth_id;
  String device_name;
  String device_imei;
  String device_iccid;
  int device_status;
  double current_latitude;
  double current_longitude;
  String device_version;
  int electric_quantity;
  int pet_id;
  String pet_name;
  bool isDone;

  ToDoState({this.id, this.auth_id, this.device_name, this.device_imei, this.device_iccid, this.device_status, this.current_latitude, this.current_longitude,
  this.device_version, this.electric_quantity, this.pet_id, this.pet_name, this.isDone}) {
    isDone = false;
  }

  @override
  ToDoState clone() {
    return ToDoState()
      ..id = id
      ..auth_id = auth_id
      ..device_name = device_name
      ..device_imei = device_imei
      ..device_iccid = device_iccid
      ..device_status = device_status
      ..current_latitude = current_latitude
      ..current_longitude = current_longitude
      ..device_version = device_version
      ..electric_quantity = electric_quantity
      ..pet_id = pet_id
      ..pet_name = pet_name
      ..isDone = isDone;
  }


  factory ToDoState.fromJson(Map<String, dynamic> json) {
    return _$ToDoStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ToDoStateToJson(this);
}
