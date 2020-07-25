import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';


class CustomDialogState implements Cloneable<CustomDialogState> {

  CustomDialogState({this.icon, this.title, this.value});
  IconData icon;
  String title;
  String value;


  @override
  CustomDialogState clone() {
    return CustomDialogState()
      ..icon = icon
      ..title = title
      ..value = value;
  }
}