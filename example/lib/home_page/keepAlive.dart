import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:sample/mixin/mixin.dart';
import './state.dart';

class HomeStateKeepAliveStf extends ComponentState<HomeState> with SingleTickerProviderStateMixin, NetWorkConnectMixin {
}