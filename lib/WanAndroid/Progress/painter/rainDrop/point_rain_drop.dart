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

  RainDropPoint({this.offset});

  //绘制
  void drawPonit(Canvas canvas, Paint paint) {
    int alpha = (255 * (MAX_RADIUS - radius) / MAX_RADIUS).toInt();
    paint.color = Color.fromARGB(alpha, 255, 255, 255);
    canvas.drawCircle(offset, radius, paint);
    radius += 0.5;
  }

  //是否有效，无效则隐藏
  bool isVaild() {
    return radius < MAX_RADIUS;
  }
}
