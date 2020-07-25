// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:amap_location_fluttify/amap_location_fluttify.dart' as amap_location;
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_map/plugin_api.dart';
// import 'package:location/location.dart';
import 'package:sample/home_page/keepAlive.dart';
import 'package:sample/home_page/pet_list/todo_component/component.dart';
import 'package:sample/home_page/fence_list/todo_component/component.dart' as fence_state;
import 'package:jpush_flutter/jpush_flutter.dart';
// import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_core_fluttify/amap_core_fluttify.dart';


// import 'package:sample/mqtt/mqtt_server_client_secure.dart' as mqtt_client;
import 'package:latlong/latlong.dart' as latlong;
import 'package:fish_redux/fish_redux.dart';
// import 'package:flutter_map/plugin_api.dart';

import 'package:sample/home_page/map/action.dart';
import 'package:sample/state_model/Res.dart';
import 'package:sample/state_model/auth.dart';
import 'package:sample/state_model/flutterMap.dart';
import 'package:sample/gps_util/animatedMapMove.dart' as animated_map;
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/Format.dart';
import 'package:sample/utils/HttpUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global_store/action.dart';
import '../global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    Lifecycle.build: _build,
    HomeAction.onDone: _onDone,
    HomeAction.onChangeTheme: _onChangeTheme,
    HomeAction.onEditFence: _onEditFence,
    HomeAction.onswitchComponent:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(200)]).withTwo<void,Action,Context<HomeState>>(_onswitchComponent),
    MapAction.switchMapStyle:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<HomeState>>(_switchMapStyle),
    MapAction.onMapMove:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<HomeState>>(_onMapMove),
    HomeAction.onRefreshFence:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<HomeState>>(_onRefreshFence),
    HomeAction.onRefreshPet:  AOP(<dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]) Function(dynamic Function(List<dynamic>, [Map<Symbol, dynamic>]))>[debounce(500)]).withTwo<void,Action,Context<HomeState>>(_onRefreshPet),
  });
}
void _init(Action action, Context<HomeState> ctx) async{
  await initPlatformState(ctx);
  await AmapCore.init('22141ac1f61df08c77574da4ce60b4d0');

  /* final JPush jpush = JPush();
  final DateTime fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
  final LocalNotification notification = LocalNotification(
      id: 234,
      title: '本地推送测试',
      buildId: 1,
      content: '这个是本地推送测试消息，请忽略',
      fireTime: fireDate,
      subtitle: '本地消息',
      badge: 5,
      extra: <String, String>{'type': 'chargingSuccess'});
  jpush.sendLocalNotification(notification)
  .then((String res) {
    println('发送了本地消息');
  });

  // ios only
  // ignore: always_specify_types
  jpush.getLaunchAppNotification().then((Map map) {
    println('获取到了本地推送：$map');
  }).catchError((dynamic error) {
    println('获取本地推送出错：$error');
  });
 */

  final HomeState state = ctx.state.clone();

  //网络状态监听
  if(state.connectivitySubscription != null) {
    state.connectivitySubscription.cancel();
    state.connectivitySubscription = null;
  }
  HomeStateKeepAliveStf().initConnectivity(ctx.context);
  final Connectivity _connectivity = Connectivity();
  state.connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult e) {
    HomeStateKeepAliveStf().updateConnectionStatus(e, ctx.context,);
   }
  );

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String token = prefs.getString('token');
  final int userId = prefs.getInt('userId');
  if(token?.isNotEmpty == true && userId == null) {
    GlobalStore.store.dispatch(GlobalActionCreator.onsaveToken(token));
  }
  
  // mqtt_client.onSubscribed('/s/test/#');
  
  final HomeState petsState = await pets(state, ctx);
  final HomeState fencesState = await fences(petsState, ctx);
  await getAuthByID(ctx, userId);
  ctx.dispatch(HomeActionCreator.updateStateAction(fencesState));
  
  await locationListen(state);
}

/// 极光推送
  Future<void> initPlatformState(Context<HomeState> ctx) async {
    final ToastCustom toast = ToastCustom();
    final JPush jpush = JPush();
    
    final bool isNotificationEnabled = await jpush.isNotificationEnabled();
    if (isNotificationEnabled == false) {
      toast.showCustomWidgetToast(msg: '推送消息未授权，请开启权限后重新进入应用！');
      jpush.openSettingsForNotification();
    }
    try {
      jpush.addEventHandler(onReceiveNotification: (Map<String, dynamic> message) async {
        print('接受到推送消息: $message');
      }, onOpenNotification: (Map<String, dynamic> message) async {
        final dynamic data = Format.getExtra(message);
        final String type = data['type'];
         switch (type) {
            case 'chargingSuccess':
              ctx.dispatch(HomeActionCreator.onSwitchComponentAction('pet_list'));
              break;
            default:
              ctx.dispatch(HomeActionCreator.onSwitchComponentAction('map'));
              break;
          }
        print('打开推送消息-------------: $message');

      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print('接受到消息-----------: $message');

      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print('flutter onReceiveNotificationAuthorization: $message');

      });
    } catch(e)  {
      toast.showCustomWidgetToast(msg: '推送消息初始化失败！');
    }

    jpush.setup(
      appKey: '7dd8f72a106a333132b75969', //你自己应用的 AppKey
      channel: 'theChannel',
      production: false,
      debug: true,
    );

    jpush.applyPushAuthority(const NotificationSettingsIOS(sound: true, alert: true, badge: true));

    jpush.getRegistrationID().then((String rid) {
      print('flutter get registration id : $rid');

    });
  }



Future<void> getAuthByID(Context<HomeState> ctx, int id) async {
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/auth/$id', method: HttpUtils.GET)
    .then((ResState res) {
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final dynamic data = res.data;
        if(data != null && data['auth'] != null) {
          final AuthState auth = AuthState.fromJson(data['auth']);
          GlobalStore.store.dispatch(GlobalActionCreator.onsaveAuth(auth));
        }
      }
    }).catchError((dynamic e) {
    });
}

void _onRefreshFence(Action action, Context<HomeState> ctx) async{
  final HomeState state = ctx.state.clone();
  state.isFenceLoading = true;
  state.isFenceEmpty = true;
  final HomeState fencesState = await fences(state, ctx);
  ctx.dispatch(HomeActionCreator.updateStateAction(fencesState));
}

void _onRefreshPet(Action action, Context<HomeState> ctx) async{
  final HomeState state = ctx.state.clone();
  state.isFenceLoading = true;
  state.isFenceEmpty = true;
  final HomeState fencesState = await pets(state, ctx);
  ctx.dispatch(HomeActionCreator.updateStateAction(fencesState));
}

void _build(Action action, Context<HomeState> ctx) async{
}

void _dispose(Action action, Context<HomeState> ctx) async{
  final HomeState state = ctx.state.clone();
  if (state.currentLocationSubscription != null) {
    state.currentLocationSubscription.cancel();
    state.currentLocationSubscription = null;
  }
  if (state.connectivitySubscription != null) {
    state.connectivitySubscription.cancel();
    state.connectivitySubscription = null;
  }
}

void _onEditFence(Action action, Context<HomeState> ctx) async{
  final HomeState state = ctx.state.clone();
  final fence_state.ToDoState toDoState = action.payload;
  for (fence_state.ToDoState item in state.fenceList) {
    if(item.id == toDoState.id) {
      item.fence_name = toDoState.fence_name;
      item.fence_desc = toDoState.fence_desc;
      item.fence_status = toDoState.fence_status;
      item.fence_positions = toDoState.fence_positions;
      item.linePoints = toDoState.linePoints;
    }
  }

  state.fenceList = state.fenceList.toList();

  ctx.dispatch(HomeActionCreator.updateStateAction(state));
}


void _onswitchComponent(Action action, Context<HomeState> ctx) async{
  final String componentName = action.payload;
  final HomeState state = ctx.state.clone();
  state.componentName = componentName;
  if (componentName != 'map') {
    await AmapLocation.stopLocation();
    state.currentLocationSubscription?.cancel();
    state.currentLocationSubscription = null;

    if (state.userState == null || state.userState?.token?.isEmpty == true || state.userState?.auth == null) {
      state.connectivitySubscription?.cancel();
      state.connectivitySubscription = null;
      Navigator.of(ctx.context).pushNamed('login');
      return;
    }

    ctx.dispatch(HomeActionCreator.updateStateAction(state));
    return;
  }
  /// 启动位置监听
  ctx.dispatch(HomeActionCreator.updateStateAction(state));
  await locationListen(state);
}

/// 获取围栏
Future<HomeState> fences(HomeState state, Context<HomeState> ctx) async {
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/fences', data: <String, int>{'page_num': state.fencePageNum, 'page_size': state.fencePageLimit}, method: HttpUtils.GET)
    .then((ResState res) {
      state.isFenceLoading = false;
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final dynamic data = res.data;
        if(data != null && data['total'] > 0) {
          state.isFenceEmpty = false;
          final List<dynamic> lists = data['lists'];
          final List<fence_state.ToDoState> _lists = lists.map((dynamic i) {
            final fence_state.ToDoState state = fence_state.ToDoState.fromJson(i);
            final List<latlong.LatLng> latLngList = <latlong.LatLng>[];
            for (String item in state.fence_positions.split(';')) {
              final List<String> latLngs = item.split(',');
               latLngList.add(latlong.LatLng(double.parse(latLngs[0]), double.parse(latLngs[1])));
            }
            state.linePoints = latLngList;
            return state;
          }).toList();
          state.fenceList = _lists;
        }
      }
    }).catchError((dynamic e) {
      state.fenceMsg = e.toString();
    });
  return state;
}

/// 获取宠物
Future<HomeState> pets(HomeState state, Context<HomeState> ctx) async {
  final HttpUtils http = HttpUtils(context: ctx.context);
  await http.request(url: '/api/v1/pets', data: <String, int>{'page_num': state.petPageNum, 'page_size': state.petPageLimit}, method: HttpUtils.GET)
    .then((ResState res) {
      state.isPetLoading = false;
      if (res != null && res.code == 200 && res.msg == 'ok') {
        final dynamic data = res.data;
        if(data != null && data['total'] > 0) {
          state.isPetEmpty = false;
          final List<dynamic> lists = data['lists'];
          final List<ToDoState> _lists = lists.map((dynamic i) {
            return ToDoState.fromJson(i);
          }).toList();
          state.petList = _lists;
        }
      }
    }).catchError((dynamic e) {
      state.petMsg = e.toString();
    });
  return state;
}

Future<void> locationListen(HomeState state) async{
  await AmapLocation.stopLocation();
  await for (final amap_location.Location currentLocation in AmapLocation.listenLocation(mode: LocationAccuracy.Low, needAddress: false, interval: 10000, distanceFilter: 1)) {
    final FlutterMapState flutterMapState = state.flutterMapState ??= FlutterMapState()..mapController = MapController();
    flutterMapState.currentLatLang = latlong.LatLng(currentLocation.latLng.latitude, currentLocation.latLng.longitude);
    flutterMapState.accuracy = currentLocation.accuracy;
    GlobalStore.store.dispatch(GlobalActionCreator.onchangeFlutterMap(flutterMapState));
  }
}

void _onDone(Action action, Context<HomeState> ctx) {
}

void _onChangeTheme(Action action, Context<HomeState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onchangeThemeColor());
}

void _switchMapStyle(Action action, Context<HomeState> ctx) {
  final FlutterMapState flutterMapState = ctx.state.flutterMapState.clone();
  flutterMapState.mapStyle = action.payload;
  GlobalStore.store.dispatch(GlobalActionCreator.onchangeFlutterMap(flutterMapState));
}

void _onMapMove(Action action, Context<HomeState> ctx) async {
  final HomeState state = ctx.state.clone();
  animated_map.animatedMapMove(state.flutterMapState.mapController, ctx, state.flutterMapState.currentLatLang, 17.0);
}
