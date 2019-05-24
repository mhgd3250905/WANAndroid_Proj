import 'dart:math';

import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
import 'package:flutter/material.dart';

class SnapchatCirclePainter extends BasePainter {
  double circleWidth;
  double circleGap;
  Color circleColor;
  Color progressColor;

  SnapchatCirclePainter(
      {this.circleColor = Colors.blue,
      this.progressColor = Colors.blue,
      this.circleWidth = 1.0,
      this.circleGap = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double radius = min(width, height) / 2 - circleWidth - circleGap;

    double scale = XAnimation.value;
    double rotateDegree = 2 * pi * scale;

    Offset center = new Offset(width / 2, height / 2);

    var circlePaint = new Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..strokeCap = StrokeCap.round;

    canvas.save();
//    canvas.translate(width / 2, height / 2);
//    canvas.rotate(rotateDegree);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: min(width, height) / 2),
        0 + rotateDegree,
        1.5 * pi,
        false,
        circlePaint);

    canvas.restore();

    var progressPaint = new Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        0 - rotateDegree, 1.5 * pi, false, progressPaint);
//
//    List<Path> wavePaths = [];
//    Path path = new Path()
//      ..moveTo(center.dx + radius * cos(rotateDegree),
//          center.dy + radius * sin(rotateDegree))
//      ..arcTo(Rect.fromCircle(center: center, radius: radius), 0,
//          1.5 * pi + rotateDegree, false)
//      ..close();
//
//    wavePaths.add(path);
//
//    canvas.saveLayer(
//        Rect.fromCircle(center: center, radius: min(width, height) / 2),
//        progressPaint);
//    canvas.drawPath(path, progressPaint);
//    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
