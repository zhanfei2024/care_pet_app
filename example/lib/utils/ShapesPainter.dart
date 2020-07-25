import 'package:flutter/material.dart';


class ShapesPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // set the paint color to be white
    // paint.color = Colors.white;

    // Create a rectangle with size and width same as the canvas
    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // draw the rectangle using the paint
    // canvas.drawRect(rect, paint);

    paint.color = Colors.yellow;

    // create a path
    final Path path = Path();
    path.lineTo(46, 0);
    path.lineTo(46, 26);
    path.lineTo(18, 26);
    path.lineTo(13, 31);
    path.lineTo(8, 26);
    path.lineTo(0, 26);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);
    /* Rect rect = Rect.fromLTWH(0.0, 0.0, 20, 30);

    Path path = Path()..arcTo(rect, 0.0, -pi / 2, true);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.orange
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);

    canvas.drawArc(
        rect,
        0.0,
        pi / 2,
        false,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke); */
 

    // set the color property of the paint
    // paint.color = Colors.red;

    // center of the canvas is (x,y) => (width/2, height/2)
    // var center = Offset(size.width / 2, size.height / 2);
    // var center = Offset(0, 0);

    // draw the circle with center having radius 75.0
    // canvas.drawCircle(center, 20.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
