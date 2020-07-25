import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'state.dart';

Widget buildView(
  LoadingState state, Dispatch dispatch, ViewService viewService) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgPicture.asset('assets/svgs/icon-icon_loading.svg', color: Colors.grey.withOpacity(0.6), width: ScreenUtil().setWidth(72),),
        SizedBox(height: ScreenUtil().setWidth(14),),
        Text(
          '加载中...',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(28)),
        )
      ]
    ) 
  );
}
