import 'dart:math';

import 'package:flutter/material.dart';

class WhtWriteRoundEye {
  double outRadius = 100.0;
  double _whtRadius = 100.0;

  //圆环的半径
  double initRadius = 60.0;

  //圆环的厚度
  double initGap = 10.0;

  //中心的半径
  double centerRadius = 15.0;

  //勾玉的大小
  double gyRadius = 10;
  int initCount = 180;
  int progress;

  //绘制
  void drawPonit(Canvas canvas, Size size, int progress) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    double width = size.width;
    double height = size.height;
    Offset center = new Offset(width / 2, height / 2);
    //绘制红色
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, outRadius, paint);
    //绘制外圈
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 5.0;
    canvas.drawCircle(center, outRadius, paint);

    canvas.save();
    //先绘制万花筒写轮眼的竖直部分
    canvas.translate(width / 2, height / 2);
    paint.strokeWidth = 2.0;

    //内环越来越收拢
    double whtRadius;
    whtRadius = _whtRadius * progress / 360;

    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;

    <int>[1, 2, 3].forEach((a) {
      double offsetAngle = 2 * a * pi / 3 + progress * 2 * pi / 360;
      Offset start = new Offset(
          whtRadius * sin(offsetAngle), whtRadius * cos(offsetAngle));
      Offset end = new Offset(
          -1 * whtRadius * sin(offsetAngle), -1 * whtRadius * cos(offsetAngle));
      Path path = new Path();
      path
        ..moveTo(start.dx, start.dy)
        ..arcToPoint(end,
            radius: Radius.circular(1.5 * whtRadius), clockwise: false)
        ..arcToPoint(start,
            radius: Radius.circular(1.5 * whtRadius), clockwise: false);
      canvas.drawPath(path, paint);
    });
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.black;
    <int>[1, 2, 3].forEach((a) {
      double offsetAngle = 2 * a * pi / 3 + progress * 2 * pi / 360;
      Offset start = new Offset(
          whtRadius * sin(offsetAngle), whtRadius * cos(offsetAngle));
      Offset end = new Offset(
          -1 * whtRadius * sin(offsetAngle), -1 * whtRadius * cos(offsetAngle));
      Path path = new Path();

      path
        ..moveTo(start.dx, start.dy)
        ..arcToPoint(end,
            radius: Radius.circular(1.5 * whtRadius), clockwise: false)
        ..arcToPoint(start,
            radius: Radius.circular(1.5 * whtRadius), clockwise: false);
      canvas.drawPath(path, paint);
    });
    canvas.restore();

    //绘制中心
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, centerRadius, paint);
  }
}
