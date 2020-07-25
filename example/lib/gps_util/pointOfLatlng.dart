import 'dart:ui';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';

class PointOfLatlng {
  static LatLng planeToLatLng({@required double maxLon, @required double minLon, @required double maxLat, @required double minLat, @required double offSetX, @required double offSetY, @required double currentLat, @required double currentLon}) {
    // 已知道屏幕的高(height)和宽(width)，地理坐标区域的范围(maxLon，minLon，maxLat，minLat)，这里我们知道了这些已知的参数。
    final int width = MediaQueryData.fromWindow(window).size.width.toInt();
    final int height = MediaQueryData.fromWindow(window).size.height.toInt();
    final double scaleX = ((maxLon-minLon))/width;
    final double scaleY = ((maxLat-minLat))/height;


    final double lon = offSetX * scaleX + currentLon;
    final double lat = -offSetY * scaleY + currentLat;
    return LatLng(lat, lon);
  }

  static LatLng pointToLatLng({@required double maxLon, @required double minLon, @required double maxLat, @required double minLat, @required double x, @required double y}) {
    // 已知道屏幕的高(height)和宽(width)，地理坐标区域的范围(maxLon，minLon，maxLat，minLat)，这里我们知道了这些已知的参数。
    final int width = MediaQueryData.fromWindow(window).size.width.toInt();
    final int height = MediaQueryData.fromWindow(window).size.height.toInt();
    final double scaleX = ((maxLon-minLon))/width;
    final double scaleY = ((maxLat-minLat))/height;


    final double lon = x * scaleX + minLon;
    final double lat = -y * scaleY + maxLat;
    return LatLng(lat, lon);
  }
}

 