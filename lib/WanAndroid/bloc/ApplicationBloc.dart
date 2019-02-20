import 'dart:async';

import 'package:douban_movies/WanAndroid/sp_utils.dart';
import 'package:flutter/material.dart';

import 'bloc_utils.dart';

class ApplicationBloc implements BlocBase {
  ThemeData _theme;

  ThemeData get getTheme => _theme;

  StreamController<ThemeData> _themeController =
      StreamController < ThemeData

  >

      .

  broadcast();

  StreamSink<ThemeData> get _themeSink => _themeController.sink;

  Stream<ThemeData> get themeStream => _themeController.stream;

  StreamController _changeThemeController = StreamController.broadcast();

  StreamSink get changeThemeSink => _changeThemeController.sink;

  ApplicationBloc() {
    _theme = new ThemeData(
      primaryColor: Colors.blue,
    );
    _changeThemeController.stream.listen(_changeTheme);
    initTheme();
  }

  @override
  void dispose() {
    _themeController.close();
    _changeThemeController.close();
  }

  void _changeTheme(data) {
    _theme = data;
    _themeSink.add(_theme);
  }

  void initTheme() async {
    _theme = new ThemeData(
      primaryColor: Color(
          await SpUtils.get(SpUtils.KEY_PRIMARYCOLOR, Colors.blue.value)),
    );
    changeThemeSink.add(_theme);
  }
}
