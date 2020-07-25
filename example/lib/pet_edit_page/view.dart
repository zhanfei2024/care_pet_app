// ignore_for_file: avoid_as
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PetEditState state, Dispatch dispatch, ViewService viewService) {
      final int width = MediaQueryData.fromWindow(window).size.width.toInt() * 2;
      final  GlobalKey _formKey=  GlobalKey<FormState>();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: const Text('宠物'),
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
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.portrait, color: Colors.grey[600],),
                            Text('头像', style: TextStyle(color: Colors.grey[600], fontSize: ScreenUtil().setSp(30)),),
                          ],
                        ),
                        width: ScreenUtil().setWidth(140),
                        alignment: AlignmentDirectional.topEnd,
                      ),
                      Expanded(
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: ScreenUtil().setWidth(170),
                                height: ScreenUtil().setWidth(170),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(85),
                                  color: Colors.grey[200],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: ScreenUtil().setWidth(160),
                                      height: ScreenUtil().setWidth(160),
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.grey[200],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                        value: state.uploadPercent ?? 0,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(80)),
                                      child: state.toDo.pet_avatar?.isNotEmpty == true ?  
                                      CachedNetworkImage(
                                        imageUrl: state.toDo.pet_avatar,
                                        width: ScreenUtil().setWidth(160),
                                        height: ScreenUtil().setWidth(160),
                                        fit: BoxFit.cover,
                                        placeholder: (BuildContext context, String url) => ClipRRect(
                                          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(80)),
                                          child: Image.asset(
                                            state.imageFile.path,
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(160),
                                            height: ScreenUtil().setWidth(160),
                                          )
                                        ),
                                        errorWidget: (BuildContext context, String url, Object error) => SizedBox(
                                          width: ScreenUtil().setWidth(100),
                                          height: ScreenUtil().setWidth(100),
                                          child: const Text('error'),
                                        ),
                                      )
                                      :
                                      GestureDetector(
                                        child: Image.asset(
                                          'assets/images/cloud_upload.png'
                                        ),
                                        onTap: () {
                                          dispatch(ToDoEditActionCreator.onUploadImageAction());
                                        }
                                      )
                                    ),
                                    
                                  ]
                                ) 
                              ),
                            state.imageFile?.path?.isNotEmpty == true ? 
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(60),
                                  height: ScreenUtil().setWidth(60),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.edit, size: 18,),
                                    onPressed: () {
                                      dispatch(ToDoEditActionCreator.onUploadImageAction());
                                    },
                                  )
                                ) 
                              ) 
                              :
                              const SizedBox(width: 0, height: 0)
                            ] 
                          ) 
                        )
                      )
                    ],
                  ),
                ),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: state.nameController,
                    decoration: InputDecoration(
                      labelText: '昵称',
                      hintText: '宠物的昵称',
                      icon: Icon(Icons.face),
                    ),
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '宠物的昵称不能为空';
                    }),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    controller: state.ageController,
                    decoration: InputDecoration(
                      labelText: '年龄',
                      hintText: '宠物的年龄',
                      icon: Icon(Icons.exposure_plus_2),
                    ),
                    validator: (String v) {
                      return v.trim().isNotEmpty == true ? null : '宠物的年龄不能为空';
                    }),
                TextFormField(
                  autofocus: false,
                  readOnly: true,
                  controller: state.genderController,
                  decoration: InputDecoration(
                    labelText: '性别',
                    hintText: '宠物的性别',
                    icon: Icon(Icons.wc),
                  ),
                  onTap: () {
                    dispatch(ToDoEditActionCreator.onChoiceGenderAction(1));
                  },
                  validator: (String v) {
                    return v.trim().isNotEmpty == true ? null : '宠物的性别不能为空';
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
                              final PetEditState _state = state.clone();
                              state.toDo.pet_name = state.nameController.text;
                              state.toDo.pet_age = int.parse(state.ageController.text);
                              dispatch(ToDoEditActionCreator.updateState(_state));
                              //验证通过提交数据
                              dispatch(ToDoEditActionCreator.onSubmitAction(<String, dynamic>{
                                'pet_avatar': state.toDo.pet_avatar, 
                                'pet_name': state.nameController.text,
                                'pet_gender': state.toDo.pet_gender,
                                'pet_age': int.parse(state.ageController.text),
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
