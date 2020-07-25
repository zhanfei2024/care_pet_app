import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'state.dart';

Widget buildView(
  ReportState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Card(
      color: Colors.blue,
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: <Widget>[
          Container(
            child: const Icon(Icons.report, size: 20,),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Text(
            '总共 ${state.total} 个围栏, ${state.done} 个应用.',
            style: const TextStyle(fontSize: 14.0, color: Colors.white),
          )
        ],
      ));
}
