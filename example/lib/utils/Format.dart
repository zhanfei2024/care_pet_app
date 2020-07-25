import 'dart:convert';
import 'dart:io';
import 'package:fish_redux/fish_redux.dart';

class Format {
  static dynamic getExtra(Map<String, dynamic> message) {
    dynamic map;
    message.forEach((String key, dynamic value) { 
      if(key == 'extras') {
        if(Platform.isIOS) {
          map = value;
          println(map);
        } else if(Platform.isAndroid) {
          final dynamic data = value;
          final String extra = data['cn.jpush.android.EXTRA'];
          map = json.decode(extra);
        }
      }
    }
  );
  println(map);
  return map;
  }
  static String formatDistance(double val) {
    String result;
    if (val > 999) {
      result = '${(val / 1000).toStringAsFixed(1)}公里';
    } else {
      result = '${val.toStringAsFixed(1)}米';
    }
    return result;
  }

  static Map<String, dynamic> formatChargerStatus(int val) {
    final Map<String, dynamic> status = <String, dynamic>{};
      if (val == 0) {
        status['text'] = '   空闲中';
        status['color'] = 0xFF55BAA8;
        status['pic'] = 'assets/icon/icon_e@3x.png';
      } else if (val == 1) {
        status['text'] = '   准备中';
        status['color'] = 0xFF3292FF;
        status['pic'] = 'assets/icon/icon_in@2x.png';
      } else if (val == 2) {
        status['text'] = '   充电中';
        status['color'] = 0xFFF1A23B;
        status['pic'] = 'assets/icon/icon_charging@3x.png';
      } else if (val == 3) {
        status['text'] = '充电完成';
        status['color'] = 0xFF3292FF;
        status['pic'] = 'assets/icon/icon_in@2x.png';
      } else if (val == 6) {
        status['text'] = '      故障';
        status['color'] = 0xFFFC8D5A;
        status['pic'] = 'assets/icon/icon_fault@2x.png';
      } else if (val == 99) {
        status['text'] = '      离线';
        status['color'] = 0xFFFF6666;
        status['pic'] = 'assets/icon/icon_openfail@2x.png';
      }
      println(status);
    return status;
  }

  // second => hh:mm:ss
  static String secondFormat(int seconds) {
    dynamic h = 0;
    dynamic m = 0;
    dynamic s = 0;
    h = seconds ~/ 3600;
    m = (seconds - h * 3600) ~/ 60;
    s = (seconds - h * 3600 - m * 60);
    if( h < 10) {
      h = '0$h';
    }
    if(m < 10) {
      m = '0$m';
    }
    if(s < 10) {
      s = '0$s';
    }
    return '$h : $m : $s';
  }
}
