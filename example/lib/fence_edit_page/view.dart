import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/global_store/action.dart';
import 'package:sample/global_store/store.dart';
import 'package:sample/gps_util/compass.dart';
import 'package:sample/gps_util/pointOfLatlng.dart';
import 'package:sample/gps_util/scale_layer_plugin_option.dart';
import 'package:sample/gps_util/zoombuttons_plugin_option.dart';
import 'package:sample/state_model/flutterMap.dart';


import 'action.dart';
import 'state.dart';

Widget buildView(
    FenceEditState state, Dispatch dispatch, ViewService viewService) {
        final Marker currentMarker = Marker(
            point: state.flutterMapState.currentLatLang,
            builder: (BuildContext ctx) => buildCompass(),
            anchorPos: AnchorPos.align(AnchorAlign.center),
        );
        state.toDo.linePoints ??= <LatLng>[];
        final List<Marker> _markers = state.toDo.linePoints.map((LatLng latlng) {
          final int _index = state.toDo.linePoints.indexWhere((LatLng element) => element == latlng);
          return  Marker(
            point: latlng,
            builder: (BuildContext ctx) => 
            Container(
                child: GestureDetector(
                  onPanStart: (DragStartDetails v) {
                    final MapController controller = state.flutterMapState.mapController;
                    final double north = controller.bounds.north;
                    final double south = controller.bounds.south;
                    final double west = controller.bounds.west;
                    final double east = controller.bounds.east;
                    final LatLng startLatLng = PointOfLatlng.pointToLatLng(maxLon: east, minLon: west, maxLat: north, minLat: south, x: v.globalPosition.dx, y: v.globalPosition.dy);
                    state.dragStart = startLatLng;
                    println('=========startLatLng===========$v');
                  },
                  onPanEnd: (DragEndDetails v) {
                    // println('================onPanEnd==============${v}');
                  },
                  onPanUpdate: (DragUpdateDetails v) {
                      // final FenceEditState _state = state.clone();
                      final MapController controller = state.flutterMapState.mapController;
                      final double north = controller.bounds.north;
                      final double south = controller.bounds.south;
                      final double west = controller.bounds.west;
                      final double east = controller.bounds.east;
                      // println('${_state.dragStart.latitude},  ${_state.dragStart.latitude}');
                      final LatLng movedLatLng = PointOfLatlng.planeToLatLng(maxLon: east, minLon: west, maxLat: north, minLat: south, offSetX: v.localPosition.dx, offSetY: v.localPosition.dy,  currentLat: state.dragStart.latitude, currentLon: state.dragStart.longitude);
                      final Map<String, dynamic> data = <String, dynamic>{
                        'index': _index,
                        'latLng': movedLatLng
                      };
                      dispatch(ToDoEditActionCreator.moveMarkerAction(data));
                      
                      // println(controller);
                      // println('LongPressMoveUpdateDetails ${v.localOffsetFromOrigin}========${_index}============');
                  },
                  onDoubleTap: () {
                    dispatch(ToDoEditActionCreator.onRemoveMarkerAction(latlng));
                  },
                    child: Icon(Icons.radio_button_checked, color: Colors.red, size: 24,),
                ),
              ),
            anchorPos: AnchorPos.align(AnchorAlign.center),
          );
        }).toList();
        _markers.add(currentMarker);
        /// 精度圆圈
        final List<CircleMarker> circleMarkers = <CircleMarker>[
          CircleMarker(
              point: state.flutterMapState.currentLatLang,
              color: Colors.blue.withOpacity(0.2),
              borderStrokeWidth: 0.2,
              useRadiusInMeter: true,
              radius: state.flutterMapState.accuracy // 2000 meters | 2 km
          ),
        ];

        final List<LatLng> pointsGradient = state.toDo.linePoints;

  return Scaffold(
    body: Stack(
    children: <Widget>[
      Column(
        children: <Widget>[
          Flexible(
            child: FlutterMap(
              mapController: state.flutterMapState.mapController,
              options: MapOptions(
                center: state.flutterMapState.currentLatLang,
                zoom: 16.0,
                plugins: <MapPlugin>[
                  ZoomButtonsPlugin(),
                  ScaleLayerPlugin()
                ],
                onTap: (LatLng v) {
                  dispatch(ToDoEditActionCreator.addPinAction(v));
                },
              ),
              layers: <LayerOptions>[
                state.flutterMapState.mapStyle == 8 ? TileLayerOptions(
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
                PolylineLayerOptions(
                  polylines: <Polyline>[
                    Polyline(
                      points: pointsGradient,
                      strokeWidth: 2.0,
                      gradientColors: <Color>[
                        Colors.yellowAccent.withOpacity(0.5)
                      ],
                    ),
                  ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              ),
              MarkerLayerOptions(
                markers: _markers
              ),
          ],
        )
      )]),
      Positioned(
        top: 10,
        left: 0,
        child: IconButton(
        icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 36,), 
        onPressed: () {
          Navigator.of(viewService.context).pop();
        })),
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
          child: DefaultTextStyle(style: TextStyle(color: Colors.white), 
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12), 
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
                    const Text('卫星')
                  ]
                ),
                onTap: () {
                  final FlutterMapState flutterMapState = state.flutterMapState.clone();
                  flutterMapState.mapStyle = 6;
                  GlobalStore.store.dispatch(GlobalActionCreator.onchangeFlutterMap(flutterMapState));
                },
              ),
              SizedBox(height: ScreenUtil().setWidth(6)),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.photo, color: Colors.white,),
                    const Text('平面')
                  ]
                ),
                onTap: () {
                  final FlutterMapState flutterMapState = state.flutterMapState.clone();
                  flutterMapState.mapStyle = 8;
                  GlobalStore.store.dispatch(GlobalActionCreator.onchangeFlutterMap(flutterMapState));
                },
              ),
              SizedBox(height: ScreenUtil().setWidth(6)),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.my_location, color: Colors.white,),
                    const Text('定位')
                  ]
                ),
                onTap: () {
                  state.flutterMapState.mapController.move(state.flutterMapState.currentLatLang, 17);
                },
              )
            ]
          ),) 
          ) 
        ) 
      )
    ]
  ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => dispatch(ToDoEditActionCreator.onDone()),
      tooltip: 'Done',
      child: const Icon(Icons.done),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
}
