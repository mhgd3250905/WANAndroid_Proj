import 'dart:math';

import 'package:flutter/material.dart';

/**
 * 定义一个雨点类
 * 功能：
 * - 在给定位置的时候，绘制对应的雨点
 * - 具有自己的动画控制
 */
class RainDropPoint {
  Offset offset;
  final double MAX_RADIUS = 30.0;
  double radius = 0.0;
  Paint _paint;
  Color _color;

  RainDropPoint({this.offset}) {
    Random random = new Random();
    _color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    _paint = new Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;
  }

  //绘制
  void drawPonit(Canvas canvas) {
    int alpha = (255 * (MAX_RADIUS - radius) / MAX_RADIUS).toInt();
    _paint.color = Color.fromARGB(alpha, _color.red, _color.green, _color.blue);
    canvas.drawCircle(offset, radius, _paint);
    radius += 0.5;
  }

  //是否有效，无效则隐藏
  bool isVaild() {
    return radius < MAX_RADIUS;
  }
}
