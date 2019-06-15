import 'dart:math';

import 'package:douban_movies/WanAndroid/Progress/painter/rainDrop/painter_rain_drop.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/rainDrop/point_rain_drop.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: 300.0,
        height: 300.0,
        child: RainDropWidget(
          width: 300.0,
          height: 300.0,
        ),
      ),
    );
  }
}

class RainDropWidget extends StatefulWidget {
  List<RainDropPoint> rainList = List();
  final width;
  final height;

  RainDropWidget({Key key, this.width, this.height}) : super(key: key);

  @override
  _RainDropWidgetState createState() => new _RainDropWidgetState(width, height);
}

class _RainDropWidgetState extends State<RainDropWidget>
    with TickerProviderStateMixin {
  AnimationController xController;
  Animation<double> xAnimation;
  AnimationController rainController;
  Animation<double> rainAnimation;
  double _width = 200;
  double _height = 200;

  _RainDropWidgetState(double width, double height) {
    _width = width ?? _width;
    _height = height ?? _height;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    xAnimation = new Tween(begin: 0.0, end: 1.0).animate(xController);
    xAnimation.addListener(_change);

    rainController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 100000));
    rainAnimation = new Tween(begin: 0.0, end: 1.0).animate(rainController);
    rainAnimation.addListener(_rainDrop);
    doDelay(rainController, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTapUp: (tapUp) {
          RenderBox getBox = context.findRenderObject();
          var localOffset = getBox.globalToLocal(tapUp.globalPosition);
          print("w: ${localOffset.dx},h: ${localOffset.dy}");
          var rainDrop =
              RainDropPoint(offset: new Offset(localOffset.dx, localOffset.dy));
          addRain(rainDrop);
        },
        onHorizontalDragUpdate: (hMove) {
          RenderBox getBox = context.findRenderObject();
          var localOffset = getBox.globalToLocal(hMove.globalPosition);
          var rainDrop =
              RainDropPoint(offset: new Offset(localOffset.dx, localOffset.dy));
          addRain(rainDrop);
        },
        onVerticalDragUpdate: (hMove) {
          RenderBox getBox = context.findRenderObject();
          var localOffset = getBox.globalToLocal(hMove.globalPosition);
          var rainDrop =
              RainDropPoint(offset: new Offset(localOffset.dx, localOffset.dy));
          addRain(rainDrop);
        },
        child: new CustomPaint(
          painter: RainDropPainter(rainList: widget.rainList),
        ),
      ),
    );
  }

  void addRain(RainDropPoint rainDrop) {
    widget.rainList.add(rainDrop);
    doDelay(xController, 0);
  }

  void _change() {
    if (widget.rainList.isEmpty) {
      print("xController stop！");
      xController.stop();
    }
    setState(() {});
  }

  void _rainDrop() {
    var random = new Random();
    addRain(RainDropPoint(
        offset: Offset(
            _width * random.nextDouble(), _height * random.nextDouble())));
  }

  void doDelay(AnimationController controller, int delay) async {
    Future.delayed(Duration(milliseconds: delay), () {
      try {
        controller..repeat();
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    xController.dispose();
    xAnimation.removeListener(_change);
    rainController.dispose();
    rainAnimation.removeListener(_rainDrop);
    super.dispose();
  }
}
