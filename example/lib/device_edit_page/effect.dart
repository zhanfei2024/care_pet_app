import 'dart:async';
import 'package:flutter/services.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/home_page/pet_list/todo_component/state.dart' as pet_state;
import 'package:sample/state_model/Res.dart';
import 'package:sample/state_model/picker.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/HttpUtils.dart';

import 'action.dart';
import 'state.dart';

Effect<DeviceEditState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceEditState>>{
    // ToDoEditAction.onDone: _onDone,
    Lifecycle.initState: _initState,
    ToDoEditAction.onChoicePet: _onChoicePet,
    ToDoEditAction.onScanImei:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<DeviceEditState>>(_onScanImei),
    ToDoEditAction.onSubmit:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<DeviceEditState>>(_onSubmit),
  });
}

/* void _onDone(Action action, Context<DeviceEditState> ctx) {
  Navigator.of(ctx.context).pop<ToDoState>(
    ctx.state.toDo.clone()
      ..desc = ctx.state.descEditController.text
      ..title = ctx.state.nameEditController.text,
  );
} */
void _initState(Action action, Context<DeviceEditState> ctx) async{
  final DeviceEditState newState = ctx.state.clone();
  newState.pickerState = await getPets(ctx);
  ctx.dispatch(ToDoEditActionCreator.updateStateAction(newState));
}

void _onSubmit(Action action, Context<DeviceEditState> ctx) async{
  final DeviceEditState state = ctx.state.clone();
  state.toDo.device_name = state.petEditController.text;
  state.toDo.device_imei = state.imeiEditController.text;
  state.toDo.device_iccid = state.iccidEditController.text;
  final ToastCustom toast = ToastCustom();
  final HttpUtils http = HttpUtils(context: ctx.context);
  if (state.isAddDevice == true) {
    await http.request(url: '/api/v1/devices', data: action.payload, method: HttpUtils.POST)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          toast.showCustomWidgetToast(msg: '新增成功');
          Navigator.of(ctx.context).pop(state.toDo);
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '新增出错了，请重试');
      });
  } else {
    await http.request(url: '/api/v1/devices/${state.toDo.id}', data: action.payload, method: HttpUtils.PUT)
      .then((ResState res) {
        if (res != null && res.code == 200 && res.msg == 'ok') {
          toast.showCustomWidgetToast(msg: '编辑成功');
          Navigator.of(ctx.context).pop(state.toDo);
        }
      }).catchError((dynamic e) {
        toast.showCustomWidgetToast(msg: '编辑出错了，请重试');
      });
  }
}

Future<List<PickerState>> getPets(Context<DeviceEditState> ctx) async {
  List<PickerState> result = <PickerState>[];
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/pets', method: HttpUtils.GET)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final dynamic data = res.data;
        if(data != null && data['total'] > 0) {
          final List<dynamic> lists = data['lists'];
          int _index = -1;
          final List<PickerState> _lists = lists.map<PickerState>((dynamic i) {
            final pet_state.ToDoState petState = pet_state.ToDoState.fromJson(i);
            _index  = _index + 1;
            return PickerState().clone()
              ..index = _index
              ..name = petState.pet_name
              ..value = petState.id
              ..selected = false;
          }).toList();
          _lists.first?.selected = true;
          result = _lists;
        }
      }
    }).catchError((dynamic e) {
    });
  return result;
}

/// 绑定宠物
void _onChoicePet(Action action, Context<DeviceEditState> ctx) {
  final ToastCustom toast = ToastCustom();
  final DeviceEditState updateState = ctx.state.clone();
  if (updateState.pickerState?.isEmpty == true) {
    toast.showCustomWidgetToast(msg: '暂无宠物，请添加宠物后再绑定');
    Navigator.of(ctx.context).pushNamed('home', arguments: <String, String>{'componentName': 'pet_list'});
    return;
  }
  void showPickerModal(BuildContext context) {
    Picker(
      columnPadding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
      cancelTextStyle: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.blue),
      selectedTextStyle: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colors.blue),
      adapter: PickerDataAdapter<String>(
        pickerdata: updateState.pickerState.map<String>((PickerState e) => e.name).toList()
      ),
      changeToFirst: true,
      selecteds: <int>[updateState.pickerState.singleWhere((PickerState e) => e.selected).index],
      hideHeader: false,
      confirmText: '确定',
      cancelText: '取消',
      onCancel: () {
        println('cancel');
      },
      onConfirm: (Picker picker, List<int> value) async{
        for (PickerState item in updateState.pickerState) {
          if(item.index == value[0]) {
            item.selected = true;
            updateState.toDo.pet_id = item.value;
            updateState.petEditController = TextEditingController(text: item.name);
          } else {
            item.selected = false;
          }
        }
        ctx.dispatch(ToDoEditActionCreator.updateStateAction(updateState));
      }
    ).showModal<dynamic>(context);
  }
  showPickerModal(ctx.context);
}

/// 扫描序列号
void _onScanImei(Action action, Context<DeviceEditState> ctx) async{
  final DeviceEditState updateState = ctx.state.clone();
  final ToastCustom toast = ToastCustom();
    final List<BarcodeFormat> _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((BarcodeFormat e) => e == BarcodeFormat.unknown);
    try {
      final ScanOptions options = ScanOptions(
        strings: <String, String>{
          'cancel': '取消',
          'flash_on': '打开闪光灯',
          'flash_off': '关闭闪光灯',
        },
        // ignore: sdk_version_ui_as_code
        restrictFormat: <BarcodeFormat>[..._possibleFormats],
        useCamera: -1,
        autoEnableFlash: false,
        android: const AndroidOptions(
          aspectTolerance: 0.00,
          useAutoFocus: true,
        ),
      );

      final ScanResult result = await BarcodeScanner.scan(options: options);
      updateState.imeiEditController = TextEditingController(text: result.rawContent);
      ctx.dispatch(ToDoEditActionCreator.updateStateAction(updateState));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        toast.showCustomWidgetToast(msg: '未授予相机权限');
        return;
      } else {
        toast.showCustomWidgetToast(msg: '未知错误');
        return;
      }
    }
}