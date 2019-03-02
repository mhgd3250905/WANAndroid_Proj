import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
import 'package:flutter/material.dart';

class TextProgressPainter extends BasePainter {
  Color progressColor;
  TextStyle textStyle;

  TextProgressPainter({this.progressColor, this.textStyle});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    if (textStyle == null) {
      textStyle = new TextStyle(
        color: Colors.yellow,
//        shadows: [
//          Shadow(color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 5.0)
//        ],

        fontSize: 80.0,
      );
    }
    TextPainter tp = TextPainter(
        text: TextSpan(
            text: '${(YAnimation.value * 100.0).toStringAsFixed(0)}%',
            style: textStyle),
        textDirection: TextDirection.rtl)
      ..layout();

    var baseLineHight =
        tp.computeDistanceToActualBaseline(TextBaseline.alphabetic);

    print('baseLine:$baseLineHight\nheight:${tp.height}');

    double textHeight = tp.height;

    Offset center = new Offset(width / 2, height / 2);
    double xMove = width * XAnimation.value;
    double yAnimValue = 0.0;
    if (YAnimation != null) {
      yAnimValue = YAnimation.value;
    }

    double yMove = height * (1.0 - yAnimValue);
    Offset waveCenter = new Offset(xMove, yMove);

    Path path = new Path()
      ..moveTo(0, height / 2)
      ..lineTo(width, height / 2)
      ..close();

    var paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawLine(Offset(0, height / 2 + baseLineHight / 2),
        Offset(width, height / 2 + baseLineHight / 2), paint);

//    canvas.saveLayer(
//        Rect.fromCircle(center: center, radius: min(width, height) / 2), paint);
    paint
      ..blendMode = BlendMode.srcATop
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0
      ..color = Colors.black;
    tp.paint(
        canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));

    canvas.drawPath(path, paint);
//    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
