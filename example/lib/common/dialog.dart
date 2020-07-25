import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/state_model/customDialog.dart';

class CustomDialog {
  static Future<String> customDialog(BuildContext ctx, List<CustomDialogState> options) async{
    final TextStyle buttonStyle = TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(26));
    final String result = await showDialog<String>(context: ctx, useRootNavigator: false, builder: (BuildContext buildContext) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(buildContext).pop('Yes');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black
            ), 
            child: Positioned(
            child: 
              Container(
                margin: const EdgeInsets.all(46.0),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: ScreenUtil().setWidth(40),
                  children: options.map((CustomDialogState e) => 
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        children: <Widget>[
                          Icon(e.icon, size: 38, color: Colors.redAccent,),
                          SizedBox(height: ScreenUtil().setWidth(20),),
                          Text(e.title, style: buttonStyle,)
                        ],
                      ),
                      onTap: () {
                        Navigator.of(buildContext).pop(e.value);
                      },
                    ),
                  ).toList()
                ),
              )
            ))
        ]
      );
    });
    return result;
  }
}