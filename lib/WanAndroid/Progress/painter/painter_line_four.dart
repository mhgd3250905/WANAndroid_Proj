import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
import 'package:flutter/material.dart';

class FourLinePainter extends BasePainter {
  double gap;
  List<Color> lineColors;
  List<double> baseHightScales;

  FourLinePainter({
    this.gap = 0,
    this.lineColors = const <Color>[
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.yellow,
    ],
    this.baseHightScales = const <double>[
      0.1,
      0.6,
      0.3,
      0.8,
    ],
  });

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    int count = lineColors.length;
    double lineWidth = (width - count * gap) / count;

    var bgPainter = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawRect(
        new Rect.fromPoints(new Offset(0.0, 0.0), new Offset(width, height)),
        bgPainter);

    double scale = XAnimation.value;

    for (int i = 0; i < count; i++) {
      var painter = new Paint()
        ..color = lineColors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = StrokeCap.round;

      Offset start =
          new Offset(width / (count * 2) + width * i / count, height);

      double lastScale = scale + baseHightScales[i];
      if (lastScale > 2.0) {
        lastScale = lastScale - 2;
      } else if (lastScale > 1.0) {
        lastScale = 2 - lastScale;
      }

      Offset end = new Offset(
          width / (count * 2) + width * i / count, height - lastScale * height);
      canvas.drawLine(start, end, painter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
