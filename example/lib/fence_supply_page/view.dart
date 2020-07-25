// ignore_for_file: avoid_as
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong/latlong.dart';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:sample/common/Style.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FenceSupplyState state, Dispatch dispatch, ViewService viewService) {
      final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
      final  GlobalKey _formKey=  GlobalKey<FormState>();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: const Text('围栏'),
      bottom: Style.preferredSize,
    ),
    body: Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
          alignment: Alignment.center,
          child: Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            autovalidate: true, //开启自动校验
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    autofocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: state.deviceEditController,
                    decoration: InputDecoration(
                      labelText: '绑定设备',
                      hintText: '选择要应用的设备',
                      icon: Icon(Icons.router),
                    ),
                    onTap: () {
                      dispatch(ToDoEditActionCreator.onChoiceDeviceAction());
                    },
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '绑定的设备不能为空';
                    }),
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: state.nameEditController,
                  decoration: InputDecoration(
                    labelText: '围栏名称',
                    hintText: '围栏的名称',
                    icon: Icon(Icons.memory),
                  ),
                  validator: (String v) {
                    return v.trim().isNotEmpty == true ? null : '围栏的名称不能为空';
                  }),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: state.descEditController,
                    decoration: InputDecoration(
                      labelText: '描述',
                      hintText: '围栏的描述',
                      icon: Icon(Icons.sim_card),
                    ),
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '围栏的描述不能为空';
                    }),
                Container(
                    // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                    margin: EdgeInsets.only(
                    top: ScreenUtil().setWidth(100), bottom: ScreenUtil().setWidth(40)),
                    width: ScreenUtil().setWidth(width),
                    child: Builder(builder: (dynamic context) {
                      return RaisedButton(
                          child: Text(
                            '确认',
                            style: Style.buttonTextStyle
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          onPressed: () {
                            if((_formKey.currentState as FormState).validate()){
                              final FenceSupplyState _state = state.clone();
                              _state.toDo.fence_name = state.nameEditController.text;
                              _state.toDo.fence_desc = state.descEditController.text;
                              _state.toDo.fence_status = 0;
                              dispatch(ToDoEditActionCreator.updateStateAction(_state));
                              //验证通过提交数据
                              final List<String> latlngs = state.toDo.linePoints.map((LatLng e) => '${e.latitude},${e.longitude}').toList();
                              dispatch(ToDoEditActionCreator.onSubmitAction(<String, dynamic>{
                                'fence_name': state.nameEditController.text,
                                'fence_desc': state.descEditController.text,
                                'fence_status': 0,
                                'fence_positions': latlngs.join(';'),
                                'device_id': state.toDo.device_id
                              }));
                            }
                          });
                    })),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
