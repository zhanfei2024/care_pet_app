 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/utils/Adapt.dart';


class Style {
  BoxDecoration boxShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
    border: Border.all(color: Colors.grey[300], width: Adapt.onepx()),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey[400].withOpacity(0.5),
        offset: const Offset(1, 5),
        blurRadius: 3,
        spreadRadius: 4)
    ]
  );
  static Color weichatColor = const Color(0xFF19AD19);
  static const PreferredSize preferredSize  = PreferredSize(child: SizedBox(width: 0, height: 0), preferredSize: Size(0, -16));
  static TextStyle buttonTextStyle = TextStyle(color: Colors.white, letterSpacing: 8, fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(34));
  static Widget svg(String assetName) {
    return SvgPicture.asset(assetName, width: ScreenUtil().setWidth(42), height: ScreenUtil().setWidth(42), color: Colors.grey,);
  }
}