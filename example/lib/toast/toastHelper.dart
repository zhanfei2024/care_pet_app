import 'dart:async';
import 'package:flutter/material.dart';

class ToastHelper {
  static void showToast(BuildContext context, String text) {

    const TextStyle style = TextStyle(color: Colors.white, fontSize: 14.0);

    final Widget widget = Center(
      child: Material(
        child: Container(
          color: Colors.black.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );

    final OverlayEntry entry = OverlayEntry(
      builder: (_) => widget,
    );

    Overlay.of(context).insert(entry);

    Timer(const Duration(seconds: 2), () {
      entry?.remove();
    });
  }

}