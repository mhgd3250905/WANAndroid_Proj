import 'package:flutter/material.dart';

class Gy2Wht {
  double outRadius = 100.0;

  //中心的半径
  double _centerRadius = 15.0;

  int progress;

  //绘制
  void drawPonit(Canvas canvas, Size size, int progress) {
    Paint _paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    double width = size.width;
    double height = size.height;
    Offset center = new Offset(width / 2, height / 2);
    //绘制红色
    _paint.color = Colors.red;
    _paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, outRadius, _paint);
    //绘制外圈
    _paint.color = Colors.black;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeCap = StrokeCap.round;
    _paint.strokeWidth = 5.0;
    canvas.drawCircle(center, outRadius, _paint);

    //内环越来越收拢
    double centerRadius;
    centerRadius = _centerRadius + (outRadius - _centerRadius) * progress / 360;

    //绘制中心
    _paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, centerRadius, _paint);
  }
}
