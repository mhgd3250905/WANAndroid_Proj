import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'WanAndroid/home_page.dart';

void main() {
  //设置debugPaintSizeEnabled为true来更直观的调试布局问题
  debugPaintSizeEnabled = false;
  return runApp(new WanAndroidMainPage());
}
