import 'dart:math' as math;
import 'package:latlong/latlong.dart';

const num PI = 3.1415926535897932384626;

const double earthRadiusMeters = 6371000.0;
const double metersPerDegree = 2.0 * PI * earthRadiusMeters / 360.0;
const double radiansPerDegree = PI / 180.0;
const double degreesPerRadian = 180.0 / PI;
double pointArr;

/*球面多边形面积计算*/
double sphericalPolygonAreaMeters2(List<LatLng> points) {
	double totalAngle = 0;
	for (int i = 0; i < points.length; i++) {
		final num j = (i + 1) % points.length;
		final num k = (i + 2) % points.length;
		totalAngle += angle(points[i], points[j], points[k]);
	}
	final num planarTotalAngle = (points.length - 2) * 180.0;
	num sphericalExcess = totalAngle - planarTotalAngle;
	if (sphericalExcess > 420.0) {
		totalAngle = points.length * 360.0 - totalAngle;
		sphericalExcess = totalAngle - planarTotalAngle;
	} else if (sphericalExcess > 300.0 && sphericalExcess < 420.0) {
		sphericalExcess = (360.0 - sphericalExcess).abs();
	}
	return sphericalExcess * radiansPerDegree * earthRadiusMeters * earthRadiusMeters;
}

/*角度*/
num angle(LatLng p1, LatLng p2, LatLng p3) {
	final num bearing21 = bearing(p2, p1);
	final num bearing23 = bearing(p2, p3);
	num angle = bearing21 - bearing23;
	if (angle < 0) {
		angle += 360;
	}
	return angle;
}

/*方向*/
num bearing(LatLng from, LatLng to) {
	final double lat1 = from.latitude * radiansPerDegree;
	final double lon1 = from.longitude * radiansPerDegree;
	final double lat2 = to.latitude * radiansPerDegree;
	final double lon2 = to.longitude * radiansPerDegree;
	double angle = -math.atan2(math.sin(lon1 - lon2) * math.cos(lat2), math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(lon1 - lon2));
	if (angle < 0) {
		angle += PI * 2.0;
	}
	angle = angle * degreesPerRadian;
	return angle;
}