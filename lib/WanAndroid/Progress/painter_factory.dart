import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/painter_circle_snapchat.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/painter_line_four.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/painter_wave.dart';
import 'package:flutter/material.dart';

abstract class BasePainterFactory {
  BasePainter getPainter();
}

class WavePainterFactory extends BasePainterFactory {
  BasePainter getPainter() {
    return WavePainter(
      waveCount: 1,
      waveColors: [
        Colors.lightBlue,
      ],
      textStyle: TextStyle(
        fontSize: 60.0,
        foreground: Paint()
          ..color = Colors.lightBlue
          ..style = PaintingStyle.fill
          ..strokeWidth = 2.0
          ..blendMode = BlendMode.difference
          ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.exclusion)
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 5.0),
//        color: Color.fromARGB(
//            255, Colors.green.red, Colors.green.green, Colors.green.blue),
        fontWeight: FontWeight.bold,
//        shadows: [
//          Shadow(
//              color: Color.fromARGB(
//                  255, Colors.grey.red, Colors.grey.green, Colors.grey.blue),
//              offset: Offset(5.0, 5.0),
//              blurRadius: 5.0)
//        ],
      ),
    );
  }
}

class SnapchatCirclePainterFactory extends BasePainterFactory {
  BasePainter getPainter() {
    return SnapchatCirclePainter(
      circleGap: 15.0,
      circleColor: Colors.pink,
      circleWidth: 20.0,
      progressColor: Colors.green,
    );
  }
}

class FourLinePainterFactory extends BasePainterFactory {
  BasePainter getPainter() {
    return FourLinePainter(
      gap: 10.0,
      lineColors: const <Color>[
        Colors.green,
        Colors.red,
        Colors.blue,
        Colors.yellow,
        Colors.pinkAccent,
      ],
      baseHightScales: const <double>[
        0.1,
        0.6,
        0.3,
        0.8,
        0.7,
      ],
    );
  }
}

//class RainDropPainterFactory extends BasePainterFactory {
//  BasePainter getPainter(List<RainDropPoint> rainList) {
//    return RainDropPainter(
//      rainList: rainList,
//    );
//  }
//}
