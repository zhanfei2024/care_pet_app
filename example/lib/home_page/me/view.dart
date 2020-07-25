import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'state.dart';

Widget buildView(
  ProfileState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
    child: Column(
      children: <Widget>[
        Card(
          child: Column(
          children: <Widget>[
            ListTile(
              dense: true,
              leading: Icon(Icons.settings),
              title: const Text('设置'),
              // subtitle: const Text('还未绑定设备'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(viewService.context).pushNamed('set');
              },
            ),
            const Divider(height: 1,),
            ListTile(
              dense: true,
              leading: Icon(Icons.dock),
              title: const Text('我的设备'),
              subtitle: const Text('还未绑定设备'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(viewService.context).pushNamed('device');
              },
            ),
            const Divider(height: 1,),
            /* ListTile(
              dense: true,
              leading: Icon(Icons.people),
              title: const Text('多账户监护'),
              subtitle: const Text('2个'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(height: 1,), */
            ListTile(
              dense: true,
              leading: Icon(Icons.notifications_active),
              title: const Text('系统通知'),
              subtitle: const Text('暂无消息'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(height: 1,),
            ListTile(
              dense: true,
              leading: Icon(Icons.file_upload),
              title: const Text('固件升级'),
              subtitle: const Text('v 1.0.0'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(height: 1,),
            ListTile(
              dense: true,
              leading: Icon(Icons.headset),
              title: const Text('帮助中心'),
              subtitle: const Text('常见问题'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ]
        ),
        ) 
      ]
    )
  );
}
