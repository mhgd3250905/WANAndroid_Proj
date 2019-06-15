import 'package:douban_movies/WanAndroid/Progress/painter/WriteRoundEye/Gy2Wht.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/WriteRoundEye/GyWriteRoundEye.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/WriteRoundEye/WhtWriteRoundEye.dart';
import 'package:douban_movies/WanAndroid/Progress/painter/WriteRoundEye/painter_write_round_eye.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: 300.0,
        height: 300.0,
        child: WriteRoundEyeWidget(
          width: 300.0,
          height: 300.0,
        ),
      ),
    );
  }
}

class WriteRoundEyeWidget extends StatefulWidget {
  final width;
  final height;
  int progress = 0;
  GyWriteRoundEye gyEye = new GyWriteRoundEye();
  WhtWriteRoundEye whtEye = new WhtWriteRoundEye();
  Gy2Wht gy2wht = new Gy2Wht();

  WriteRoundEyeWidget({Key key, this.width, this.height}) : super(key: key);

  @override
  _WriteRoundEyeWidgetState createState() =>
      new _WriteRoundEyeWidgetState(width, height);
}

class _WriteRoundEyeWidgetState extends State<WriteRoundEyeWidget>
    with TickerProviderStateMixin {
  AnimationController xController;
  Animation<double> xAnimation;
  double _width = 200;
  double _height = 200;

  _WriteRoundEyeWidgetState(double width, double height) {
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
    doDelay(xController, 0);
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.progress / 360).floor() == 0) {
      widget.progress++;
    } else if ((widget.progress / 360).floor() == 1) {
      widget.progress += 10;
    } else {
      widget.progress += 2;
    }
    if (widget.progress > 1079) {
      widget.progress = 1080 - 1;
    }

    print("progress=${widget.progress}");
    return Container(
      child: new CustomPaint(
        painter: WriteRoundEyePainter(widget.progress,
            gyWriteRoundEye: widget.gyEye,
            whtWriteRoundEye: widget.whtEye,
            gy2wht: widget.gy2wht),
      ),
    );
  }

  void _change() {
    setState(() {});
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
    super.dispose();
  }
}
