// ignore_for_file: avoid_as
import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DeviceEditState state, Dispatch dispatch, ViewService viewService) {
      final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
      final  GlobalKey _formKey=  GlobalKey<FormState>();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: const Text('设备'),
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
                    keyboardType: TextInputType.text,
                    controller: state.nameEditController,
                    decoration: InputDecoration(
                      labelText: '设备名称',
                      hintText: '设备的名称',
                      icon: Icon(Icons.router),
                    ),
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '设备的名称不能为空';
                    }),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    controller: state.imeiEditController,
                    decoration: InputDecoration(
                      labelText: '序列号',
                      hintText: '设备的序列号',
                      icon: Icon(Icons.memory),
                      suffixIcon: IconButton(icon: Icon(Icons.photo_camera), onPressed: () {
                        dispatch(ToDoEditActionCreator.onScanImeiAction());
                      },),
                    ),
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '设备的序列号不能为空';
                    }),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    controller: state.iccidEditController,
                    decoration: InputDecoration(
                      labelText: 'SIM卡卡号',
                      hintText: '设备的SIM卡卡号',
                      icon: Icon(Icons.sim_card),
                    ),
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '设备的SIM卡卡号不能为空';
                    }),
                TextFormField(
                  autofocus: false,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  controller: state.petEditController,
                  decoration: InputDecoration(
                    labelText: '绑定宠物',
                    hintText: '绑定您的宠物',
                    icon: Icon(Icons.favorite_border),
                  ),
                  onTap: () {
                    dispatch(ToDoEditActionCreator.onChoicePetAction());
                  },
                  validator: (String v) {
                    return v.trim().isNotEmpty == true ? null : '绑定的宠物不能为空';
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
                              //验证通过提交数据
                              dispatch(ToDoEditActionCreator.onSubmitAction(<String, dynamic>{
                                'auth_id': state.userState.auth.id,
                                'pet_id': state.toDo.pet_id,
                                'device_name': state.nameEditController.text,
                                'device_imei': state.imeiEditController.text,
                                'device_iccid': state.iccidEditController.text
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
