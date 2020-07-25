
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:sample/toast/toastCustom.dart';
import 'package:sample/utils/Permission.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:latlong/latlong.dart';

class Navigate {
  static void onNavigate(LatLng toPosition, String name) async{
    // final bool permission = await Permission.applyPermission(PermissionGroup.location);
    // if(permission == true) { 
      final LatLng currentLatlng = LatLng(22.34444, 114.233333);
      final LatLng position = toPosition;
      if(Platform.isAndroid == true) {
        // android
        final String baiduUrl = 'baidumap://map/direction?origin=${currentLatlng.latitude},${currentLatlng.longitude}&destination=${position.latitude},${position.longitude}&coord_type=bd09ll&mode=driving&src=ios.baidu.openAPIdemo';
        final String tenxunUrl = 'qqmap://map/routeplan?type=drive&fromcoord=${currentLatlng.latitude},${currentLatlng.longitude}&tocoord=${position.latitude},${position.longitude}&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77';
        final String amapUrl = 'amapuri://route/plan/?sid=&slat=${currentLatlng.latitude}&slon=${currentLatlng.longitude}&sname=A&did=&dlat=${position.latitude}&dlon=${position.longitude}&dname=B&dev=0&t=0';
        final List<String> maps = <String>[amapUrl, tenxunUrl, baiduUrl,];
         for (String url in maps) {
          if (await canLaunch(url)) {
            await launch(url);
            break;
          }
        }
      } else if(Platform.isIOS == true) {
        MapsLauncher.launchCoordinates(position.latitude, position.longitude, name);
      }
    /* } else {
      final ToastCustom toast = ToastCustom();
      toast.showCustomWidgetToast(msg: '你拒绝了定位权限，无法为你查询到附近充电站，需要在权限管理中开启定位权限，再打开应用');
    } */
  }
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}