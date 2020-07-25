import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'state.dart';

Widget buildView(
  ReportState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Card(
      color: Colors.cyan,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
        child: Row(
          children: <Widget>[
            Container(
              child: const Icon(Icons.report, size: 20, color: Colors.white,),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Text(
              '总共 ${state.total} 个围栏, ${state.done} 个应用.',
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            )
          ],
        ),
      ) );
}
