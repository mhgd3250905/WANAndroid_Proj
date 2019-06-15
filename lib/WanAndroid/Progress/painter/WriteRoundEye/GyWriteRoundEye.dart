import 'dart:math';

import 'package:flutter/material.dart';

class GyWriteRoundEye {
  double outRadius = 100.0;
  double whtRadius = 100.0;

  //圆环的半径
  double _initRadius = 60.0;

  //圆环的厚度
  double initGap = 10.0;

  //中心的半径
  double centerRadius = 15.0;

  //勾玉的大小
  double _gyRadius = 10;
  int _initCount = 180;
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
    double initRadius, gyRadius, initCount;
    initRadius = _initRadius * (360 - progress) / 360;
    //勾玉越来越小，缩小的速率毕内环要慢一倍
    gyRadius = _gyRadius * (360 - 0.7 * progress) / 360;
    //内圈的齿数越来越小
    initCount = _initCount * (360 - 0.7 * progress) / 360;

    //绘制内圈
    Offset start, end;
    _paint.strokeWidth = 1;
    for (int i = 0; i < initCount; i++) {
      start = Offset(initRadius * sin(2 * pi * (i + 1) / initCount) + center.dx,
          initRadius * cos(2 * pi * (i + 1) / initCount) + center.dy);
      end = Offset(
          (initRadius + initGap) * sin(2 * pi * (i + 1) / initCount) +
              center.dx,
          (initRadius + initGap) * cos(2 * pi * (i + 1) / initCount) +
              center.dy);
      canvas.drawLine(start, end, _paint);
    }
    canvas.save();
    canvas.translate(width / 2, height / 2);
    //绘制3个逗号
    double gyCenterGap = initRadius;
    Offset gyStart;
    <int>[1, 2, 3].forEach((a) {
      double offsetAngle = 2 * a * pi / 3 + progress * 2 * pi / 360;

      gyStart = new Offset((gyCenterGap - gyRadius) * sin(offsetAngle),
          (gyCenterGap - gyRadius) * cos(offsetAngle));

      _paint.style = PaintingStyle.fill;

      Path gyPath = new Path();

      Offset p1 = new Offset((gyCenterGap + 3 * gyRadius) * sin(offsetAngle),
          (gyCenterGap + 3 * gyRadius) * cos(offsetAngle));

      Offset p2 = new Offset((gyCenterGap + 2 * gyRadius) * sin(offsetAngle),
          (gyCenterGap + 2 * gyRadius) * cos(offsetAngle));

      gyPath
        ..lineTo(gyStart.dx, gyStart.dy)
        ..arcToPoint(p1,
            radius: Radius.circular(1.5 * gyRadius),
            largeArc: true,
            clockwise: false)
        ..arcToPoint(p2,
            radius: Radius.circular(0.5 * gyRadius),
            largeArc: true,
            clockwise: true)
        ..arcToPoint(gyStart,
            radius: Radius.circular(1 * gyRadius),
            largeArc: true,
            clockwise: false);

      canvas.drawPath(gyPath, _paint);
    });
    canvas.restore();
    //绘制中心
    _paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, centerRadius, _paint);
  }
}
