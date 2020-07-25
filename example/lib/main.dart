
import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';


import 'app.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light));

  
  runApp(createApp());
  


} 
