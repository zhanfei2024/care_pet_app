// ignore_for_file: avoid_as
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:sample/home_page/keepAlive.dart';

void animatedMapMove(MapController mapController, Context<dynamic> ctx, LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final Tween<double> _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final Tween<double> _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final Tween<double> _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    final TickerProvider tickerProvider = ctx.stfState as HomeStateKeepAliveStf;

    // Create a animation controller that has a duration and a TickerProvider.
    final AnimationController controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: tickerProvider);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }