import 'dart:math';

import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
import 'package:flutter/material.dart';

class CirclePainter extends BasePainter {
  List<Color> waveColors;
  double circleWidth;
  double circleGap;
  Color circleColor;
  Color progressColor;

  CirclePainter(
      {this.waveColors,
      this.circleColor = Colors.blue,
      this.progressColor = Colors.blue,
      this.circleWidth = 1.0,
      this.circleGap = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double radius = min(width, height) / 2 - circleWidth - circleGap;
    double degree = 2 * pi * YAnimation.value;
    Offset center = new Offset(width / 2, height / 2);

    var circlePaint = new Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;

    canvas.drawCircle(center, min(width, height) / 2, circlePaint);

    var progressPaint = new Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill
      ..strokeWidth = circleWidth;

    List<Path> wavePaths = [];

    Path path = new Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx, center.dy + radius)
      ..arcTo(Rect.fromCircle(center: center, radius: radius), 0, degree, true)
      ..lineTo(center.dy, center.dy)
      ..close();

    wavePaths.add(path);
    canvas.saveLayer(
        Rect.fromCircle(center: center, radius: min(width, height) / 2),
        progressPaint);
    canvas.drawPath(path, progressPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
