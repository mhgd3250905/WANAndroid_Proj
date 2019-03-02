import 'package:douban_movies/WanAndroid/Progress/painter/painter_base.dart';
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
      textStyle:
      TextStyle(
        fontSize: 60.0,
        foreground: Paint()
          ..color = Colors.lightBlue
          ..style = PaintingStyle.fill
          ..strokeWidth = 2.0
          ..blendMode = BlendMode.difference
          ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.exclusion)
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1.0),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
