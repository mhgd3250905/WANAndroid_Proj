import 'package:flutter/material.dart';

class IconFontUtils {
  static getIcon(int codePoint) {
    return Icon(IconData(codePoint, fontFamily: "IconFont"));
  }
}
