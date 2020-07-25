
class Angle {
  static String formatDistance(double val) {
    String result;
    if (val > 999) {
      result = '${(val / 1000).toStringAsFixed(1)}公里';
    } else {
      result = '${val.toStringAsFixed(1)}米';
    }
    return result;
  }
}
