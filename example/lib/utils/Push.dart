// ignore_for_file: avoid_classes_with_only_static_members
import 'dart:async';

// import 'package:rammus/rammus.dart' as rammus;

import 'dart:ui';
import 'package:flutter/material.dart';

class Push {
  
   // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await Rammus.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    /* if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    }); */
  }
}
