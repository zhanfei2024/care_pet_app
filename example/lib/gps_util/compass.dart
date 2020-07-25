import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

Widget buildCompass() {
    return StreamBuilder<double>(
      stream: FlutterCompass.events,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final double direction = snapshot.data;
        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return const Center(
            child: Text('Device does not have sensors !'),
          );

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                offset: const Offset(3.0, 0.0),
                blurRadius: 0,
                spreadRadius: 0.0)
            ]
          ),
          child: Transform.rotate(
            angle: ((direction ?? 0) * (math.pi / 180) * -1),
            child: Icon(Icons.navigation, color: Colors.blueAccent, size: 32,),
          ),
        );
      },
    );
  }