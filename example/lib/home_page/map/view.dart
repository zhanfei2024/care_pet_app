
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_map/flutter_map.dart';
import 'package:sample/gps_util/scale_layer_plugin_option.dart';
import 'package:sample/gps_util/zoombuttons_plugin_option.dart';
import 'package:sample/gps_util/compass.dart' as compass;
import 'package:sample/home_page/fence_list/todo_component/component.dart';


import 'action.dart';
import 'state.dart';

Widget buildView(
  MapState state,
  Dispatch dispatch,
  ViewService viewService,
) {

  final Marker currentMarker = Marker(
      point: state.currentLatLang,
      builder: (BuildContext ctx) => compass.buildCompass(),
      anchorPos: AnchorPos.align(AnchorAlign.center),
  );
  final List<Marker> _markers = <Marker>[];
  _markers.add(currentMarker);
  
  // 围栏
  final List<Polyline> polylineList = <Polyline>[];
  for (ToDoState item in state.fenceList) {
    if(item.fence_status == 1) {
      polylineList.add(
        Polyline(
          points: item.linePoints,
          strokeWidth: ScreenUtil().setWidth(3),
          color: Colors.red,
          borderStrokeWidth: ScreenUtil().setWidth(2),
          borderColor: Colors.yellow,
          colorsStop: <double>[ScreenUtil().setWidth(2), ScreenUtil().setWidth(2), ScreenUtil().setWidth(2), ScreenUtil().setWidth(2)],
          isDotted: true,
        ),
      );
    }
  }

  /// 精度圆圈
  final List<CircleMarker> circleMarkers = <CircleMarker>[
    CircleMarker(
        point: state.currentLatLang,
        color: Colors.blue.withOpacity(0.2),
        borderStrokeWidth: 0.2,
        useRadiusInMeter: true,
        radius: state.accuracy // 2000 meters | 2 km
    ),
  ];

  state.mapController.onRotationChanged = (double v) {

  };
  return Stack(
    children: <Widget>[
      Column(
      children: <Widget>[
        Flexible(
            child: FlutterMap(
              mapController: state.mapController,
              options: MapOptions(
                center: state.currentLatLang,
                zoom: 16.0,
                plugins: <MapPlugin>[
                  ZoomButtonsPlugin(),
                  ScaleLayerPlugin()
                ],
                onTap: (LatLng v) {
                  dispatch(MapActionCreator.addPinAction(v));
                },
                onPositionChanged: (MapPosition m, bool b) {
                  println('${m.center}$b');
                }
              ),
              layers: <LayerOptions>[
                state.mapStyle == 8 ? TileLayerOptions(
                  urlTemplate: 'https://webrd01.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=12&style=8&x={x}&y={y}&z={z}',
                  additionalOptions: <String, String>{
                  },
                  subdomains: <String>['01', '02', '03', '04'], //多域名请求
                  maxZoom: 17,
                  maxNativeZoom: 17,
                  keepBuffer: 10,
                ) : TileLayerOptions(
                  urlTemplate: 'https://webst01.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=12&style=6&x={x}&y={y}&z={z}',
                  additionalOptions: <String, String>{
                  },
                  subdomains: <String>['01', '02', '03', '04'], //多域名请求
                  maxZoom: 17,
                  maxNativeZoom: 17,
                  keepBuffer: 10,
                ),
                MarkerLayerOptions(
                  markers: _markers
                ),
              PolylineLayerOptions(
                polylines: polylineList.toList()
              ),
              CircleLayerOptions(circles: circleMarkers),
              ZoomButtonsPluginOption(
                minZoom: 4,
                maxZoom: 19,
                mini: true,
                padding: 10,
                alignment: Alignment.bottomRight),
              ScaleLayerPluginOption(
                lineColor: Colors.blue,
                lineWidth: 2,
                textStyle: TextStyle(color: Colors.blue, fontSize: 12),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              )
            ],
          )
        )]),
        Positioned(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const <double>[0, 0.4, 1],
                colors: const <Color>[Color(0x6C000000), Color(0x4C000000), Color(0x00000000)]
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 100,
          child: Container(
            width: 40,
            // height: 120,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.26),
              borderRadius: BorderRadius.circular(8)
            ),
            child: DefaultTextStyle(style: TextStyle(color: Colors.blue), 
            child: DefaultTextStyle(
              style: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.white), 
              child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 8,
              children: <Widget>[
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.public,
                        color: Colors.white,
                      ),
                      Text('卫星', style: TextStyle(fontSize: ScreenUtil().setSp(24)),)
                    ]
                  ),
                  onTap: () {
                    dispatch(MapActionCreator.switchMapStyleAction(6));
                  },
                ),
                SizedBox(height: ScreenUtil().setWidth(4)),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.photo, color: Colors.white,),
                      Text('平面', style: TextStyle(fontSize: ScreenUtil().setSp(24)),)
                    ]
                  ),
                  onTap: () {
                    dispatch(MapActionCreator.switchMapStyleAction(8));
                  },
                ),
                SizedBox(height: ScreenUtil().setWidth(4)),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.my_location, color: Colors.white,),
                      Text('定位', style: TextStyle(fontSize: ScreenUtil().setSp(24)),)
                    ]
                  ),
                  onTap: () {
                    state.mapController.move(state.currentLatLang, 17);
                  },
                ),
                SizedBox(height: ScreenUtil().setWidth(4)),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.timeline, color: Colors.white,),
                      Text('轨迹', style: TextStyle(fontSize: ScreenUtil().setSp(24)),)
                    ]
                  ),
                  onTap: () {
                    state.mapController.move(state.currentLatLang, 17);
                  },
                )
              ]
            ),) 
            ) 
          ) 
        )
      ]
  );
}
