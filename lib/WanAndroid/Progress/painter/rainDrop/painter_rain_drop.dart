import 'package:douban_movies/WanAndroid/Progress/painter/rainDrop/point_rain_drop.dart';
import 'package:flutter/material.dart';

class RainDropPainter extends CustomPainter {
  List<RainDropPoint> rainList = List();
//  Paint _paint = new Paint()
//    ..style = PaintingStyle.stroke
//    ..strokeWidth = 1.0
//    ..strokeCap = StrokeCap.round;

  RainDropPainter({@required this.rainList});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    var bgPainter = new Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill;

    //绘制背景
    canvas.drawRect(
        new Rect.fromPoints(new Offset(0.0, 0.0), new Offset(width, height)),
        bgPainter);

    rainList.forEach((rain) {
      rain.drawPonit(canvas);
    });

    rainList.removeWhere((rain) {
      return !rain.isVaild();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
