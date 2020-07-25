

class Format {
  
  static String deviceStatus(int v) {
    switch (v) {
      case 0:
        return '断开';
        break;
      case 1:
        return '连接';
        break;
      default:
        return '异常';
        break;
    }
  }
  static String fenceStatus(int v) {
    switch (v) {
      case 0:
        return '关闭';
        break;
      case 1:
        return '开启';
        break;
      default:
        return '异常';
        break;
    }
  }
}