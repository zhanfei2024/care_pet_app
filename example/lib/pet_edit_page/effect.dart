import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/home_page/action.dart';
import 'package:sample/state_model/Res.dart';
import 'package:sample/state_model/picker.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/HttpUtils.dart';


import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<PetEditState> buildEffect() {
  return combineEffects(<Object, Effect<PetEditState>>{
    Lifecycle.initState: _initState,
    // ToDoEditAction.onDone: _onDone,
    ToDoEditAction.onChangeTheme: _onChangeTheme,
    ToDoEditAction.onUploadImage: _onUploadImage,
    ToDoEditAction.onChoiceGender: _onChoiceGender,
    ToDoEditAction.onSubmit: _onSubmit,
  });
}

dynamic _initState(Action action, Context<PetEditState> ctx) async{
  ///cashDrawList
  final PetEditState state = ctx.state.clone();
  state.genders = <PickerState>[
    PickerState(name: 'GG',index: 0, selected: true, value: 1 ),
    PickerState(name: 'MM',index: 1, selected: false, value: 2 ),
    PickerState(name: '绝育GG',index: 2, selected: false, value: 3 ),
    PickerState(name: '绝育MM',index: 3, selected: false, value: 4 ),
  ];
  ctx.dispatch(ToDoEditActionCreator.updateState(state));
}

/* void _onDone(Action action, Context<PetEditState> ctx) {
  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.nickeNameController.text
      ..title = ctx.state.ageController.text,
  );
} */
void _onSubmit(Action action, Context<PetEditState> ctx) async{
  final PetEditState state = ctx.state.clone();
  final ToastCustom toast = ToastCustom();
  final HttpUtils http = HttpUtils(context: ctx.context);
  if (state.isAddDevice == true) {
    await http.request(url: '/api/v1/pets', data: action.payload, method: HttpUtils.POST)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          toast.showCustomWidgetToast(msg: '新增成功');
          ctx.dispatch(HomeActionCreator.addPetAction(state.toDo));
          Navigator.of(ctx.context).popAndPushNamed('home', arguments: <String, dynamic>{'componentName': 'pet_list'});
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '新增出错了，请重试');
      });
  } else {
    await http.request(url: '/api/v1/pets/${state.toDo.id}', data: action.payload, method: HttpUtils.PUT)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          toast.showCustomWidgetToast(msg: '编辑成功');
          ctx.dispatch(HomeActionCreator.addPetAction(state.toDo));
          Navigator.of(ctx.context).popAndPushNamed('home', arguments: <String, dynamic>{'componentName': 'pet_list'});
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '编辑出错了，请重试');
      });
  }
}

void _onChangeTheme(Action action, Context<PetEditState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}
void _onUploadImage(Action action, Context<PetEditState> ctx) async{
  final PetEditState state = ctx.state.clone();
  final TextStyle buttonStyle = TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(24));
  final String result = await showDialog<String>(context: ctx.context, useRootNavigator: false, builder: (BuildContext buildContext) {
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
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add_a_photo, size: 38, color: Colors.blue,),
                        Text('打开相机', style: buttonStyle,)
                      ],
                    ),
                    onTap: () {
                      Navigator.of(buildContext).pop('camera');
                    },
                  ),
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add_photo_alternate, size: 38, color: Colors.blue,),
                        Text('打开相册', style: buttonStyle,)
                      ],
                    ),
                    onTap: () {
                      Navigator.of(buildContext).pop('gallery');
                    },
                  )
                ],
              ),
            )
          ))
      ]
    );
  });
  if(result == 'camera') {
    _onImageButtonPressed(state, ImageSource.camera, ctx);
  } else if (result == 'gallery') {
    _onImageButtonPressed(state, ImageSource.gallery, ctx);
  }
}

Text _getRetrieveErrorWidget(PetEditState state) {
    if (state.retrieveDataError != null) {
      final Text result = Text(state.retrieveDataError);
      state.retrieveDataError = null;
      return result;
    }
    return null;
  }

Widget previewImage(PetEditState state) {
  final Text retrieveError = _getRetrieveErrorWidget(state);
  if (retrieveError != null) {
    return retrieveError;
  }
  if (state.imageFile != null) {
      return Image.file(File(state.imageFile.path));
  } else if (state.pickImageError != null) {
    return Text(
      'Pick image error: ${state.pickImageError}',
      textAlign: TextAlign.center,
    );
  } else {
    return const Text(
      '你还没有选择照片.',
      textAlign: TextAlign.center,
    );
  }
}

Future<void> retrieveLostData(PetEditState state) async {
  final LostData response = await state.picker.getLostData();
  if (response.isEmpty) {
    return;
  }
  if (response.file != null) {
    state.imageFile = response.file;
  } else {
    state.retrieveDataError = response.exception.code;
  }
}


typedef void OnPickImageCallback(double maxWidth, double maxHeight, int quality);


/// 选择上传图片
void _onImageButtonPressed(PetEditState state, ImageSource source, Context<PetEditState> ctx) async {
  final ToastCustom toast = ToastCustom();
  final PetEditState _state = state.clone();
  try {
    final PickedFile pickedFile = await state.picker.getImage(source: source);
    _state.imageFile = pickedFile;
    /// 上传图片至服务器
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'image': await MultipartFile.fromFile(_state.imageFile.path, filename: _state.imageFile.path),
    });
    final Dio dio = Dio();
    await dio.post<dynamic>('http://192.168.1.100:8000/upload', data: formData, onSendProgress:  (int sent, int total) {
      final PetEditState updateState = state.clone();
      updateState.uploadPercent = (sent / total);
      ctx.dispatch(ToDoEditActionCreator.updateState(updateState));
      print('${sent / total}');
    },).then((Response<dynamic> res) {
      if(res.statusCode != 200) {
        toast.showCustomWidgetToast(msg: '上传失败，请重试');
        return;
      }
      toast.showCustomWidgetToast(msg: '上传成功');
      state.toDo.pet_avatar = 'http://192.168.1.100:8000/${res.data['data']['image_save_url']}';
    });
  } catch (e) {
    _state.pickImageError = e;
  }
  ctx.dispatch(ToDoEditActionCreator.updateState(_state));
}

/// 选择性别
void _onChoiceGender(Action action, Context<PetEditState> ctx) {
  final PetEditState updateState = ctx.state.clone();
  void showPickerModal(BuildContext context) {
    Picker(
      columnPadding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
      cancelTextStyle: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.blue),
      selectedTextStyle: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colors.blue),
      adapter: PickerDataAdapter<String>(
        pickerdata: updateState.genders.map<String>((PickerState e) => e.name).toList()
      ),
      changeToFirst: true,
      selecteds: <int>[updateState.genders.firstWhere((PickerState e) => e.selected).index],
      hideHeader: false,
      confirmText: '确定',
      cancelText: '取消',
      onCancel: () {
        println('cancel');
      },
      onConfirm: (Picker picker, List<int> value) async{
        for (PickerState item in updateState.genders) {
          if(item.index == value[0]) {
            item.selected = true;
            updateState.toDo.pet_gender = item.value;
            updateState.genderController = TextEditingController(text: item.name);
          } else {
            item.selected= false;
          }
        }
        ctx.dispatch(ToDoEditActionCreator.updateState(updateState));
      }
    ).showModal<dynamic>(context);
  }
  showPickerModal(ctx.context);
}
