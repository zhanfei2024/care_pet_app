import 'package:fish_redux/fish_redux.dart';


class PickerState implements Cloneable<PickerState> {

  // ignore: empty_constructor_bodies
  PickerState({this.index, this.name, this.value, this.selected}){
    index = index;
    name = name;
    value = value;
    selected = selected;
  }

  int index;
  String name;
  dynamic value;
  bool selected;


  @override
  PickerState clone() {
    return PickerState()
      ..index = index
      ..name = name
      ..value = value
      ..selected = selected;
  }
}