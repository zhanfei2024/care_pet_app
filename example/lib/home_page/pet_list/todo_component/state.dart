// ignore_for_file: non_constant_identifier_names
import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class ToDoState implements Cloneable<ToDoState> {
  int id;
  String pet_avatar;
  String pet_name;
  int pet_gender;
  int pet_age;
  int pet_step;
  int pet_status;
  bool isBindDevice;
  int index;

  ToDoState({this.id, this.pet_avatar, this.pet_name, this.pet_gender, this.pet_age, this.pet_step, this.pet_status, this.isBindDevice, this.index}) {
    isBindDevice = false;
  }

  @override
  ToDoState clone() {
    return ToDoState()
      ..id = id
      ..pet_avatar = pet_avatar
      ..pet_name = pet_name
      ..pet_gender = pet_gender
      ..pet_age = pet_age
      ..pet_step = pet_step
      ..pet_status = pet_status
      ..isBindDevice = isBindDevice
      ..index = index;
  }

  /* @override
  String toString() {
    return 'ToDoState{uniqueId: $uniqueId, title: $title, desc: $desc, isDone: $isDone}';
  } */

  factory ToDoState.fromJson(Map<String, dynamic> json) {
    return _$ToDoStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ToDoStateToJson(this);
}
