import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/home_page/fence_list/action.dart';

import 'action.dart';
import 'pet_list/action.dart';
import 'state.dart';

Widget buildView(
    HomeState state, Dispatch dispatch, ViewService viewService) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true); 
    final int  currentIndex = <String>['map', 'fence_list', 'pet_list', 'me'].indexWhere((String element) => element == state.componentName);
    final List<Widget> appBars = <Widget>[
      const PreferredSize(child: SizedBox(width: 0, height: 0), preferredSize: Size(0, 0)),
      AppBar(
        title: const Text('围栏'), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              dispatch(FenceListActionCreator.onAddAction());
          })
        ],
        bottom: const PreferredSize(child: SizedBox(width: 0, height: 0), 
        preferredSize: Size(0, -16))
      ),
      AppBar(
        title: const Text('宠物'), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              dispatch(PetListActionCreator.onAddAction());
          })
        ],
        bottom: const PreferredSize(child: SizedBox(width: 0, height: 0), preferredSize: Size(0, -16))
      ),
      // const PreferredSize(child: SizedBox(width: 0, height: 0), preferredSize: Size(0, 0)),
      AppBar(title: const Text('我的'), bottom: const PreferredSize(child: SizedBox(width: 0, height: 0), preferredSize: Size(0, -16))),
    ];
  return Scaffold(
    appBar: appBars[currentIndex],
    body: viewService.buildComponent(state.componentName),
    bottomNavigationBar: BottomNavigationBar( // 底部导航
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), title: const Text('地图')),
          BottomNavigationBarItem(icon: Icon(Icons.panorama_wide_angle), title: const Text('围栏')),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), title: const Text('宠物')),
          BottomNavigationBarItem(icon: Icon(Icons.face), title: const Text('我')),
        ],
        currentIndex: <String>['map', 'fence_list', 'pet_list', 'me'].indexWhere((String element) => element == state.componentName),
        fixedColor: Colors.blue,
        onTap: (int v) {
          String componentName;
          switch (v) {
            case 0:
              componentName = 'map';
              break;
            case 1:
              componentName = 'fence_list';
              break;
            case 2:
              componentName = 'pet_list';
              break;
            case 3:
              componentName = 'me';
              break;
            default:
              componentName = 'map';
              break;
          }
          dispatch(HomeActionCreator.onSwitchComponentAction(componentName));
        },
      ),
  );
}
