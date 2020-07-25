// ignore_for_file: non_constant_identifier_names
import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class ToDoState implements Cloneable<ToDoState> {
  int id;
  String fence_name;
  String fence_desc;
  int fence_status;
  String fence_positions;
  int device_id;
  int mapStyle;
  num accuracy;
  List<LatLng> linePoints;

  ToDoState({this.id, this.fence_name, this.fence_desc, this.fence_status, this.fence_positions, this.device_id, this.mapStyle, this.accuracy, this.linePoints});

  @override
  ToDoState clone() {
    return ToDoState()
              ..id = id
              ..fence_name = fence_name
              ..fence_desc = fence_desc
              ..fence_status = fence_status
              ..fence_positions = fence_positions
              ..device_id = device_id
              ..mapStyle = mapStyle
              ..accuracy = accuracy
              ..linePoints = linePoints;
  }

  factory ToDoState.fromJson(Map<String, dynamic> json) {
    return _$ToDoStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ToDoStateToJson(this);
}
