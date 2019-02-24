import 'dart:math';

import 'package:flutter/material.dart';

class PainterFactory{
  BasePainter getWavePainter(){
    return WavePainter(
        waveCount: 2,
        waveColors: [
          Color.fromARGB(
              100, Colors.pink.red, Colors.pink.green, Colors.pink.blue),
          Color.fromARGB(
              150, Colors.pink.red, Colors.pink.green, Colors.pink.blue),
        ],
        circleColor: Colors.green,
        circleBackgroundColor: Colors.yellow,
        circleWidth: 3.0);
  }
}

abstract class BasePainter extends CustomPainter{
  Animation<double> _xAnimation;
  Animation<double> _yAnimation;

  set XAnimation(Animation<double> value) {
    _xAnimation = value;
  }

  set YAnimation(Animation<double> value) {
    _yAnimation = value;
  }
}

class WavePainter extends BasePainter {
  int waveCount;
  double waveHeight;
  List<Color> waveColors;
  double circleWidth;
  Color circleColor;
  Color circleBackgroundColor;

  WavePainter({
    this.waveCount = 1,
    this.waveHeight,
    this.waveColors,
    this.circleColor = Colors.blue,
    this.circleBackgroundColor = Colors.white,
    this.circleWidth = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    if (waveHeight == null) {
      waveHeight = height / 8;
    }

    if (waveColors == null) {
      waveColors = [
        Color.fromARGB(
            100, Colors.blue.red, Colors.blue.green, Colors.blue.blue)
      ];
    }

    Offset center = new Offset(width / 2, height / 2);
    double xMove = width * _xAnimation.value;
    double yAnimValue = 0.0;
    if (_yAnimation != null) {
      yAnimValue = _yAnimation.value;
    }
    double yMove = height * (1.0 - yAnimValue);
    Offset waveCenter = new Offset(xMove, yMove);


    var paintCircle = new Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;

    canvas.drawCircle(center, min(width, height) / 2, paintCircle);

    List<Path> wavePaths = [];

    for (int i = 0; i < waveCount; i++) {
      double direction = pow(-1.0, i);
      Path path = new Path()
        ..moveTo(waveCenter.dx - width, waveCenter.dy)
        ..lineTo(waveCenter.dx - width, center.dy + height / 2)
        ..lineTo(waveCenter.dx + width, center.dy + height / 2)
        ..lineTo(waveCenter.dx + width, waveCenter.dy)
        ..quadraticBezierTo(
            waveCenter.dx + width * 3 / 4,
            waveCenter.dy + waveHeight * direction,
            waveCenter.dx + width / 2,
            waveCenter.dy)
        ..quadraticBezierTo(
            waveCenter.dx + width / 4,
            waveCenter.dy - waveHeight * direction,
            waveCenter.dx,
            waveCenter.dy)
        ..quadraticBezierTo(
            waveCenter.dx - width / 4,
            waveCenter.dy + waveHeight * direction,
            waveCenter.dx - width / 2,
            waveCenter.dy)
        ..quadraticBezierTo(
            waveCenter.dx - width * 3 / 4,
            waveCenter.dy - waveHeight * direction,
            waveCenter.dx - width,
            waveCenter.dy)
        ..close();

      wavePaths.add(path);
    }
    var paint = new Paint()
      ..color = circleBackgroundColor
      ..style = PaintingStyle.fill;

    canvas.saveLayer(
        Rect.fromCircle(center: center, radius: min(width, height) / 2), paint);
    canvas.drawCircle(center, min(width, height) / 2, paint);
    paint
      ..blendMode = BlendMode.srcATop
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    for (int i = 0; i < wavePaths.length; i++) {
      if (waveColors.length >= wavePaths.length) {
        paint.color = waveColors[i];
      } else {
        paint.color = waveColors[0];
      }
      canvas.drawPath(wavePaths[i], paint);
    }
    paint.blendMode = BlendMode.src;

    canvas.restore();

    TextPainter tp = TextPainter(
        text: TextSpan(
            text: '${(yAnimValue * 100.0).toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 60.0,
              color: Color.fromARGB(
                  100, Colors.blue.red, Colors.blue.green, Colors.blue.blue),
              fontWeight: FontWeight.bold,
            )),
        textDirection: TextDirection.rtl)
      ..layout();

    tp.paint(
        canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}