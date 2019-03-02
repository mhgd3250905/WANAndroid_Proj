import 'package:flutter/material.dart';

abstract class BasePainter extends CustomPainter{
  Animation<double> _xAnimation;
  Animation<double> _yAnimation;

  set XAnimation(Animation<double> value) {
    _xAnimation = value;
  }

  set YAnimation(Animation<double> value) {
    _yAnimation = value;
  }

  Animation<double> get YAnimation => _yAnimation;

  Animation<double> get XAnimation => _xAnimation;

}