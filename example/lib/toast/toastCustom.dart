import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastCustom {

  void showCustomWidgetToast({@required String msg, Icon icon, Duration duration = const Duration(milliseconds: 2000)}) {
    final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;

    final Widget w = Container(
        constraints: BoxConstraints(
          maxWidth: ScreenUtil().setWidth(width*0.8)
        ),
        margin: EdgeInsetsDirectional.only(bottom: ScreenUtil().setWidth(100)),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(16), horizontal: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
          color: Colors.black.withOpacity(0.7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              msg,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: ScreenUtil().setSp(28)),
            ),
          ],
        ),
      );

    showToastWidget(w, position: ToastPosition.bottom, duration: duration);
  }
}

