import 'dart:math';

import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
import 'package:flutter/material.dart';

class WavePainter extends BasePainter {
  int waveCount;
  int crestCount;
  double waveHeight;
  List<Color> waveColors;
  double circleWidth;
  Color circleColor;
  Color circleBackgroundColor;
  bool showProgressText;
  TextStyle textStyle;

  WavePainter(
      {this.waveCount = 1,
      this.crestCount = 2,
      this.waveHeight,
      this.waveColors,
      this.circleColor = Colors.grey,
      this.circleBackgroundColor = Colors.white,
      this.circleWidth = 5.0,
      this.showProgressText = true,
      this.textStyle = const TextStyle(
        fontSize: 60.0,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 5.0)
        ],
      )});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    if (waveHeight == null) {
      waveHeight = height / 8;
      height = height + waveHeight;
    }

    if (waveColors == null) {
      waveColors = [
        Color.fromARGB(
            100, Colors.blue.red, Colors.blue.green, Colors.blue.blue)
      ];
    }

    Offset center = new Offset(width / 2, height / 2);
    double xMove = width * XAnimation.value;
    double yAnimValue = 0.0;
    if (YAnimation != null) {
      yAnimValue = YAnimation.value;
    }
    double yMove = height * (1.0 - yAnimValue);
    Offset waveCenter = new Offset(xMove, yMove);

    var paintCircle = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 5.0);

    canvas.drawCircle(center, min(width, height) / 2, paintCircle);

    List<Path> wavePaths = [];

    for (int index = 0; index < waveCount; index++) {
      double direction = pow(-1.0, index);
      Path path = new Path()
        ..moveTo(waveCenter.dx - width, waveCenter.dy)
        ..lineTo(waveCenter.dx - width, center.dy + height / 2)
        ..lineTo(waveCenter.dx + width, center.dy + height / 2)
        ..lineTo(waveCenter.dx + width, waveCenter.dy);

      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < crestCount; j++) {
          double a = pow(-1.0, j);
          path
            ..quadraticBezierTo(
                waveCenter.dx +
                    width * (1 - i - (1 + 2 * j) / (2 * crestCount)),
                waveCenter.dy + waveHeight * a * direction,
                waveCenter.dx +
                    width * (1 - i - (2 + 2 * j) / (2 * crestCount)),
                waveCenter.dy);
        }
      }

      path..close();

      wavePaths.add(path);
    }
    var paint = new Paint()
      ..color = circleBackgroundColor
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 5.0);

    canvas.saveLayer(
        Rect.fromCircle(center: center, radius: min(width, height) / 2), paint);

    canvas.drawCircle(center, min(width, height) / 2, paint);

    paint
      ..blendMode = BlendMode.srcATop
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 10.0);

    for (int i = 0; i < wavePaths.length; i++) {
      if (waveColors.length >= wavePaths.length) {
        paint.color = waveColors[i];
      } else {
        paint.color = waveColors[0];
      }
      canvas.drawPath(wavePaths[i], paint);
    }
//    paint.blendMode = BlendMode.srcATop;
    if (showProgressText) {
      TextPainter tp = TextPainter(
          text: TextSpan(
              text: '${(yAnimValue * 100.0).toStringAsFixed(0)}%',
              style: textStyle),
          textDirection: TextDirection.rtl)
        ..layout();

      tp.paint(
          canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
