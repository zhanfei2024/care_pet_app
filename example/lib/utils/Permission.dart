import 'dart:async';


/* enum PermissionGroup {
  /// 未知权限仅用于返回类型，从未请求
  unknown,

  /// Android: 日历
  /// iOS: 日历 (Events)
  calendar,

  /// Android: 相机
  /// iOS: 相片 (Camera Roll and Camera)
  camera,

  /// Android: 联络人
  /// iOS: 地址簿
  contacts,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Android: Microphone
  /// iOS: Microphone
  microphone,

  /// Android: Phone
  /// iOS: Nothing
  phone,

  /// Android: Nothing
  /// iOS: Photos
  photos,

  /// Android: Nothing
  /// iOS: Reminders
  reminders,

  /// Android: Body Sensors
  /// iOS: CoreMotion
  sensors,

  /// Android: Sms
  /// iOS: Nothing
  sms,

  /// Android: External Storage
  /// iOS: Nothing
  storage,

  /// Android: Microphone
  /// iOS: Speech
  speech,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse,

  /// Android: None
  /// iOS: MPMediaLibrary
  mediaLibrary
}
enum PermissionStatus {
  /// 用户拒绝了访问请求的功能的权限。
  denied,

  /// 用户授予访问该功能的权限，但该功能已禁用。
  disabled,

  /// 用户授予访问请求的功能的权限。
  granted,

  /// 用户授予了对请求功能的受限访问权限 (only on iOS).
  restricted,

  /// 权限处于未知状态
  unknown
}

/// 定义与权限组相关的服务状态
enum ServiceStatus {
  /// 未知的服务状态表示无法确定服务的状态.
  unknown,

  /// 所提供的权限组没有服务.
  notApplicable,

  /// 提供的权限组的服务已禁用.
  disabled,

  /// 所提供的权限组的服务已启用.
  enabled
} */



/* class Permission {
  static Future<bool> applyPermission(PermissionGroup permission) async{
    // 显示请求权限的理由（仅适用于Android），只有当用户同时点选了拒绝开启权限和不再提醒后才会true
    // 在iOS上始终返回false
    final bool noAsk = await PermissionHandler().shouldShowRequestPermissionRationale(permission);

    // 权限检查结果
    final PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(permission);
    // 用户未授权
    if(permissionStatus != PermissionStatus.granted) {
      // 如果权限询问不出现，跳转至设置页
      if(noAsk == true) {
        await PermissionHandler().openAppSettings();
        return false;
      // 如果权限询问出现，申请权限
      } else {
        // 没允许进行提示
        // 检测权限是否允许, 允许就进行下一步
        await PermissionHandler().requestPermissions(<PermissionGroup>[permission]);
        final PermissionStatus ageinPermissionStatus = await PermissionHandler().checkPermissionStatus(permission);
        if(ageinPermissionStatus == PermissionStatus.granted) {
          // 下一步
          return true;
        } else {
          return false;
        }
      }
    } else {
      // 用户已授权
      return true;
    }
  }
} */
