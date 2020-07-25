import 'dart:convert';

class Notification {
  static Map<String, dynamic> getExtra(Map<String, dynamic> message) {
    Map<String, dynamic> map;
    message.forEach((String key, dynamic value) { 
      if(key == 'extras') {
        final dynamic data = value;
        final String extra = data['cn.jpush.android.EXTRA'];
        map = json.decode(extra);
        }
      }
    );
    return map;
  }
}