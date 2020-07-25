// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:ui';
import 'package:flutter/material.dart';

class Adapt {
    static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    static final double _width = mediaQuery.size.width;
    static final double _height = mediaQuery.size.height;
    static final double _topbarH = mediaQuery.padding.top;
    static final double _botbarH = mediaQuery.padding.bottom;
    static final double _pixelRatio = mediaQuery.devicePixelRatio;
    static double _ratio;
    static void init(int number){
        final int uiwidth = number is int ? number : 750;
        _ratio = _width / uiwidth;
    }
    static double px(int number){
        if(!(_ratio is double || _ratio is int)) { 
          Adapt.init(750); }
        return number * _ratio;
    }
    static double onepx(){
        return 1/_pixelRatio;
    }
    static double screenW(){
        return _width;
    }
    static double screenH(){
        return _height;
    }
    static double padTopH(){
        return _topbarH;
    }
    static double padBotH(){
        return _botbarH;
    }
}
